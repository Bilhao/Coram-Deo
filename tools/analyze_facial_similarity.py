#!/usr/bin/env python3
"""
tools/analyze_facial_similarity.py

Analisa a similaridade fisionômica de todas as 366 imagens de santos em assets/images/santos/.
Utiliza YuNet para detecção facial e SFace para extração de embeddings faciais e cálculo
de similaridade por cosseno.
"""

import os
import glob
import sqlite3
import cv2
import numpy as np
from PIL import Image

PROJECT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
IMAGES_DIR = os.path.join(PROJECT_DIR, "assets", "images", "santos")
DB_PATH = os.path.join(PROJECT_DIR, "assets", "santos.db")
MODELS_DIR = os.path.join(PROJECT_DIR, "tools", "models")
YUNET_PATH = os.path.join(MODELS_DIR, "face_detection_yunet.onnx")
SFACE_PATH = os.path.join(MODELS_DIR, "face_recognition_sface.onnx")
OUTPUT_DIR = os.path.join(PROJECT_DIR, "tools", "facial_clusters")

os.makedirs(OUTPUT_DIR, exist_ok=True)

def load_saints_db():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    c.execute("SELECT dia, mes, nome, subtitulo FROM santos ORDER BY mes, dia")
    rows = {(r[1], r[0]): (r[2], r[3]) for r in c.fetchall()}
    conn.close()
    return rows

def main():
    print("Iniciando auditoria facial de todas as imagens...")
    saints_info = load_saints_db()
    
    detector = cv2.FaceDetectorYN_create(YUNET_PATH, "", (1024, 1024), 0.5, 0.3, 5000)
    recognizer = cv2.FaceRecognizerSF_create(SFACE_PATH, "")

    files = sorted(glob.glob(os.path.join(IMAGES_DIR, "santo_*.webp")))
    print(f"Total de arquivos encontrados: {len(files)}")

    features = {}
    aligned_faces = {}
    metadata = {}

    no_face_detected = []

    for fpath in files:
        fname = os.path.basename(fpath)
        # Parse month and day from santo_MM_DD.webp
        parts = fname.replace("santo_", "").replace(".webp", "").split("_")
        mes, dia = int(parts[0]), int(parts[1])
        nome, subtitulo = saints_info.get((mes, dia), ("Desconhecido", ""))
        key = f"{mes:02d}_{dia:02d}"

        img = cv2.imread(fpath)
        if img is None:
            continue

        h, w, _ = img.shape
        detector.setInputSize((w, h))
        _, faces = detector.detect(img)

        if faces is None or len(faces) == 0:
            # Fallback com threshold menor
            detector.setScoreThreshold(0.3)
            _, faces = detector.detect(img)
            detector.setScoreThreshold(0.5)

        if faces is None or len(faces) == 0:
            no_face_detected.append((key, nome))
            continue

        # Seleciona o rosto com maior área (o mais proeminente / central)
        best_face = max(faces, key=lambda f: f[2] * f[3])
        aligned = recognizer.alignCrop(img, best_face)
        feat = recognizer.feature(aligned)

        features[key] = feat
        aligned_faces[key] = aligned
        metadata[key] = {
            "key": key,
            "dia": dia,
            "mes": mes,
            "nome": nome,
            "subtitulo": subtitulo,
            "face_box": [int(x) for x in best_face[:4]],
        }

    print(f"Rostos detectados e mapeados: {len(features)} / {len(files)}")
    if no_face_detected:
        print(f"Imagens sem rosto detectado ({len(no_face_detected)}):")
        for k, n in no_face_detected:
            print(f"  - {k}: {n}")

    # Calcular similaridade par-a-par
    keys = list(features.keys())
    pairs = []

    for i in range(len(keys)):
        k1 = keys[i]
        feat1 = features[k1]
        for j in range(i + 1, len(keys)):
            k2 = keys[j]
            feat2 = features[k2]
            sim = recognizer.match(feat1, feat2, cv2.FaceRecognizerSF_FR_COSINE)
            pairs.append((sim, k1, k2))

    pairs.sort(reverse=True, key=lambda x: x[0])

    print("\n" + "="*80)
    print("TOP 50 PARES COM MAIOR SIMILARIDADE FACIAL (POSSÍVEIS CLONES / FISIONOMIA IGUAL):")
    print("="*80)

    for idx, (sim, k1, k2) in enumerate(pairs[:50], 1):
        s1 = metadata[k1]
        s2 = metadata[k2]
        print(f"#{idx:02d} | Similaridade: {sim:.4f}")
        print(f"     A: [{k1}] {s1['nome']} ({s1['subtitulo']})")
        print(f"     B: [{k2}] {s2['nome']} ({s2['subtitulo']})")

    # Identificar clusters de santos altamente similares (sim >= 0.65)
    # Grafo de componentes conectados
    adj = {k: set() for k in keys}
    threshold_cluster = 0.65
    for sim, k1, k2 in pairs:
        if sim >= threshold_cluster:
            adj[k1].add(k2)
            adj[k2].add(k1)

    visited = set()
    clusters = []
    for k in keys:
        if k not in visited and len(adj[k]) > 0:
            cluster = []
            queue = [k]
            visited.add(k)
            while queue:
                curr = queue.pop(0)
                cluster.append(curr)
                for neighbor in adj[curr]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)
            if len(cluster) > 1:
                clusters.append(cluster)

    clusters.sort(key=lambda c: len(c), reverse=True)

    print("\n" + "="*80)
    print(f"GRUPOS / CLUSTERS DE ROSTOS QUASE IDÊNTICOS (Similaridade >= {threshold_cluster}):")
    print("="*80)
    for idx, cluster in enumerate(clusters, 1):
        print(f"\n--- CLUSTER #{idx} ({len(cluster)} santos com o mesmo rosto) ---")
        for k in cluster:
            m = metadata[k]
            print(f"  • [{k}] {m['nome']} — {m['subtitulo']}")

        # Salvar montagem lado a lado do cluster para inspeção visual
        crop_list = [aligned_faces[k] for k in cluster[:10]] # max 10
        if crop_list:
            montage = np.hstack(crop_list)
            out_path = os.path.join(OUTPUT_DIR, f"cluster_{idx:02d}_size_{len(cluster)}.jpg")
            cv2.imwrite(out_path, montage)

if __name__ == "__main__":
    main()

