#!/usr/bin/env python3
"""
tools/regenerate_verified_flaws.py

Script para regenerar as imagens de santos que apresentaram defeitos
visuais (3 mãos, clones/pessoas idênticas, problemas iconográficos ou ausência).

Contém a lista canônica de todas as imagens auditadas, com proteção
explícita das imagens já aprovadas pelo usuário.
"""

import os
import sys

# IMAGENS EXPLICITAMENTE APROVADAS PELO USUÁRIO — NUNCA ALTERAR NENHUMA!
APPROVED_IMAGES_DO_NOT_TOUCH = {
    "01_25",  # Conversão de São Paulo
    "08_13",  # Santa Dulce dos Pobres
    "08_19",  # São João Eudes
    "08_22",  # Nossa Senhora Rainha
    "08_24",  # São Bartolomeu
    "08_27",  # Santa Mônica
    "09_05",  # Santa Teresa de Calcutá
    "12_30",  # São Rogério de Canas
    "06_24",  # Natividade de São João Batista
    "06_22",  # Tomás More e João Fisher
    "07_26",  # Joaquim e Ana
    "08_01",  # Afonso de Ligório
    "08_07",  # Sisto II e Companheiros
}

# Fila completa de correções com prompts canônicos dedicados
FLAWED_IMAGES_REGISTRY = {
    # JÁ REGENERADAS E APLICADAS COM SUCESSO:
    "01_06": {"nome": "Epifania do Senhor", "status": "CONCLUIDO"},
    "04_19": {"nome": "Santo Expedito", "status": "CONCLUIDO"},
    "04_08": {"nome": "Santa Júlia Billiart", "status": "CONCLUIDO"},
    "02_16": {"nome": "Santa Juliana de Nicomédia", "status": "CONCLUIDO"},
    "01_29": {"nome": "São Gildas de Rhuys", "status": "CONCLUIDO"},
    "01_27": {"nome": "Santa Ângela Mérici", "status": "CONCLUIDO"},
    "01_16": {"nome": "São Marcelo I", "status": "CONCLUIDO"},
    "04_25": {"nome": "São Marcos", "status": "CONCLUIDO"},
    "05_05": {"nome": "Santo Ângelo de Jerusalém", "status": "CONCLUIDO"},
    "05_20": {"nome": "São Bernardino de Sena", "status": "CONCLUIDO"},
    "05_27": {"nome": "Santo Agostinho de Cantuária", "status": "CONCLUIDO"},
    "06_06": {"nome": "São Norberto", "status": "CONCLUIDO"},
    "06_11": {"nome": "São Barnabé", "status": "CONCLUIDO"},

    # RESTANTES NA FILA (Aguardando reset de cota ou chave dedicada):
    # 3 Mãos:
    "06_16": {"nome": "São João Francisco Régis", "defeito": "3 mãos"},
    "06_28": {"nome": "Santo Irineu", "defeito": "3 mãos"},
    "12_16": {"nome": "Santa Adelaide", "defeito": "3 mãos"},
    "12_20": {"nome": "São Domingos de Silos", "defeito": "3 mãos"},
    "01_01": {"nome": "Santa Maria, Mãe de Deus", "defeito": "3 mãos"},
    "02_14": {"nome": "Santos Cirilo e Metódio", "defeito": "3 mãos"},
    "06_02": {"nome": "Santos Marcelino e Pedro", "defeito": "3 mãos"},
    "04_17": {"nome": "São Roberto de Molesme", "defeito": "3 mãos"},

    # Estranhas / A refazer:
    "04_20": {"nome": "Santa Inês de Montepulciano", "defeito": "Estranha"},
    "06_13": {"nome": "Santo Antônio de Pádua", "defeito": "Estranha"},
    "06_26": {"nome": "São Josemaria Escrivá", "defeito": "Estranha / Fisionomia incorreta"},
    "08_10": {"nome": "São Lourenço", "defeito": "Estranha / Mão na grelha"},
    "08_28": {"nome": "Santo Agostinho", "defeito": "Estranha"},
    "11_16": {"nome": "Santa Margarida da Escócia", "defeito": "Estranha"},
    "12_07": {"nome": "Santo Ambrósio", "defeito": "Estranha"},
    "12_08": {"nome": "Imaculada Conceição de Nossa Senhora", "defeito": "Estranha"},
    "12_13": {"nome": "Santa Luzia", "defeito": "Estranha"},
    "12_27": {"nome": "São João Evangelista", "defeito": "Estranha"},
    "12_28": {"nome": "Santos Inocentes", "defeito": "Estranha"},

    # Clones / Duas pessoas iguais:
    "05_12": {"nome": "Santos Nereu e Aquiles", "defeito": "Duas pessoas iguais (clones)"},
    "06_14": {"nome": "Santos Rufino e Valério", "defeito": "Duas pessoas iguais (clones)"},
    "11_09": {"nome": "Dedicação da Basílica de Latrão", "defeito": "Clone do Papa Leão Magno"},
    "11_10": {"nome": "São Leão Magno", "defeito": "Clone de 11_09"},

    # Ausentes / Banco corrigido:
    "05_29": {"nome": "São Paulo VI", "defeito": "Ausente"},
    "08_16": {"nome": "Santo Estêvão da Hungria", "defeito": "Ausente"},
    "08_29": {"nome": "Martírio de São João Batista", "defeito": "Ausente"},
    "12_24": {"nome": "Vigília do Natal do Senhor", "defeito": "Tema atualizado (Adão e Eva removidos)"},
}

if __name__ == "__main__":
    print(f"Total de itens no registro: {len(FLAWED_IMAGES_REGISTRY)}")
    concluidos = sum(1 for v in FLAWED_IMAGES_REGISTRY.values() if v.get("status") == "CONCLUIDO")
    print(f"Concluídos: {concluidos}")
    print(f"Pendentes: {len(FLAWED_IMAGES_REGISTRY) - concluidos}")
    print(f"Protegidos (NÃO ALTERAR): {len(APPROVED_IMAGES_DO_NOT_TOUCH)}")
