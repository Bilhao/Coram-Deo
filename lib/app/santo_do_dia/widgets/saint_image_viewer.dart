import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Utilitários para compartilhamento e salvamento de imagens do Santo do Dia.
class SaintImageService {
  static const MethodChannel _channel = MethodChannel(
    'com.bilhao.coramdeo/media_saver',
  );

  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.bilhao.coramdeo&hl=pt_BR&gl=BR';

  /// Obtém o arquivo físico da imagem (seja de asset, cache local ou rede).
  static Future<File?> resolveImageFile({
    required String? assetPath,
    required String? localPath,
    required String? networkUrl,
  }) async {
    try {
      // 1. Imagem local já persistida no disco (ignora arquivos legados em .jpg)
      if (localPath != null &&
          localPath.isNotEmpty &&
          !localPath.toLowerCase().endsWith('.jpg')) {
        final file = File(localPath);
        if (await file.exists()) {
          return file;
        }
      }

      // 2. Imagem embutida nos assets
      if (assetPath != null && assetPath.isNotEmpty) {
        final byteData = await rootBundle.load(assetPath);
        final tempDir = await getTemporaryDirectory();
        final ext = p.extension(assetPath).isNotEmpty
            ? p.extension(assetPath)
            : '.webp';
        final fileName =
            'santo_temp_${DateTime.now().millisecondsSinceEpoch}$ext';
        final tempFile = File(p.join(tempDir.path, fileName));
        await tempFile.writeAsBytes(
          byteData.buffer.asUint8List(
            byteData.offsetInBytes,
            byteData.lengthInBytes,
          ),
          flush: true,
        );
        return tempFile;
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  /// Compartilha a imagem com texto descritivo nativamente (WhatsApp, etc.).
  static Future<void> shareSaintImage(
    BuildContext context, {
    required String name,
    required String subtitulo,
    required String? assetPath,
    required String? localPath,
    required String? networkUrl,
  }) async {
    try {
      final file = await resolveImageFile(
        assetPath: assetPath,
        localPath: localPath,
        networkUrl: networkUrl,
      );

      final shareText = subtitulo.isNotEmpty
          ? '$name\n$subtitulo\n\nCoram Deo:\n$playStoreUrl'
          : '$name\n\nCoram Deo:\n$playStoreUrl';

      if (file != null && await file.exists()) {
        await Share.shareXFiles([
          XFile(file.path, mimeType: 'image/webp'),
        ], text: shareText);
      } else if (networkUrl != null && networkUrl.isNotEmpty) {
        await Share.share('$shareText\n$networkUrl');
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Não foi possível compartilhar a imagem.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  /// Salva a imagem no armazenamento do dispositivo (Galeria/Fotos no Android).
  static Future<void> downloadSaintImage(
    BuildContext context, {
    required String name,
    required String? assetPath,
    required String? localPath,
    required String? networkUrl,
  }) async {
    try {
      final sourceFile = await resolveImageFile(
        assetPath: assetPath,
        localPath: localPath,
        networkUrl: networkUrl,
      );

      if (sourceFile == null || !await sourceFile.exists()) {
        throw Exception("Arquivo de imagem não encontrado");
      }

      final sanitized = name
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9]'), '_')
          .replaceAll(RegExp(r'_+'), '_');
      final fileName = 'santo_$sanitized';

      bool saved = false;

      // 1. Tenta salvar na Galeria via MediaStore nativo (Android 10+)
      if (Platform.isAndroid) {
        try {
          final result = await _channel.invokeMethod<bool>(
            'saveImageToGallery',
            {'filePath': sourceFile.path, 'title': fileName},
          );
          if (result == true) {
            saved = true;
          }
        } catch (_) {
          // MethodChannel indisponível ou falhou
        }
      }

      // 2. Fallback via seletor nativo do sistema (SAF / FilePicker)
      if (!saved) {
        final bytes = await sourceFile.readAsBytes();
        final path = await FilePicker.platform.saveFile(
          dialogTitle: 'Salvar imagem do santo',
          fileName: '$fileName.webp',
          type: FileType.custom,
          allowedExtensions: ['webp', 'jpg', 'png'],
          bytes: bytes,
        );
        if (path != null) {
          saved = true;
        } else {
          // Usuário cancelou o diálogo de salvamento
          return;
        }
      }

      if (context.mounted && saved) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Imagem salva com sucesso!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Não foi possível salvar a imagem.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}

/// Visualizador em tela cheia da pintura sacra com suporte a zoom interativo.
class SaintFullscreenViewer extends StatefulWidget {
  final String name;
  final String subtitulo;
  final String? assetPath;
  final String? localPath;
  final String? networkUrl;
  final String heroTag;

  const SaintFullscreenViewer({
    super.key,
    required this.name,
    required this.subtitulo,
    required this.heroTag,
    this.assetPath,
    this.localPath,
    this.networkUrl,
  });

  @override
  State<SaintFullscreenViewer> createState() => _SaintFullscreenViewerState();
}

class _SaintFullscreenViewerState extends State<SaintFullscreenViewer>
    with SingleTickerProviderStateMixin {
  bool _showControls = true;
  late TransformationController _transformationController;
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;
  TapDownDetails? _doubleTapDetails;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 250),
        )..addListener(() {
          if (_animation != null) {
            _transformationController.value = _animation!.value;
          }
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    final Matrix4 current = _transformationController.value;
    final Matrix4 target;

    if (current != Matrix4.identity()) {
      target = Matrix4.identity();
    } else {
      const double scale = 2.5;
      final position =
          _doubleTapDetails?.globalPosition ??
          Offset(
            MediaQuery.of(context).size.width / 2,
            MediaQuery.of(context).size.height / 2,
          );
      final double x = position.dx * (1 - scale);
      final double y = position.dy * (1 - scale);
      target = Matrix4.diagonal3Values(scale, scale, 1.0)
        ..setTranslationRaw(x, y, 0.0);
    }

    _animation = Matrix4Tween(begin: current, end: target).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward(from: 0);
  }

  Widget _buildImage() {
    if (widget.assetPath != null && widget.assetPath!.isNotEmpty) {
      return Image.asset(
        widget.assetPath!,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      );
    }
    if (widget.localPath != null &&
        widget.localPath!.isNotEmpty &&
        File(widget.localPath!).existsSync()) {
      return Image.file(
        File(widget.localPath!),
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      );
    }
    if (widget.networkUrl != null && widget.networkUrl!.isNotEmpty) {
      return Image.network(
        widget.networkUrl!,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Área da Imagem com Zoom em Tela Inteira (Sem cortes/clipping restrito)
          InteractiveViewer(
            transformationController: _transformationController,
            minScale: 1.0,
            maxScale: 5.0,
            clipBehavior: Clip.none,
            child: SizedBox.expand(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _showControls = !_showControls;
                  });
                },
                onDoubleTapDown: (details) {
                  _doubleTapDetails = details;
                },
                onDoubleTap: _handleDoubleTap,
                child: Center(
                  child: Hero(tag: widget.heroTag, child: _buildImage()),
                ),
              ),
            ),
          ),

          // Barra Superior com Título e Ações
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: _showControls ? 0 : -100,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                bottom: 12,
                left: 8,
                right: 8,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    tooltip: 'Fechar',
                    onPressed: () {
                      if (_transformationController.value !=
                          Matrix4.identity()) {
                        _transformationController.value = Matrix4.identity();
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.subtitulo.isNotEmpty)
                          Text(
                            widget.subtitulo,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    tooltip: 'Compartilhar',
                    onPressed: () {
                      SaintImageService.shareSaintImage(
                        context,
                        name: widget.name,
                        subtitulo: widget.subtitulo,
                        assetPath: widget.assetPath,
                        localPath: widget.localPath,
                        networkUrl: widget.networkUrl,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.download, color: Colors.white),
                    tooltip: 'Salvar imagem',
                    onPressed: () {
                      SaintImageService.downloadSaintImage(
                        context,
                        name: widget.name,
                        assetPath: widget.assetPath,
                        localPath: widget.localPath,
                        networkUrl: widget.networkUrl,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Exibe o menu inferior (BottomSheet) ao pressionar longamente a imagem.
void showSaintImageActionsSheet(
  BuildContext context, {
  required String name,
  required String subtitulo,
  required String? assetPath,
  required String? localPath,
  required String? networkUrl,
  required String heroTag,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (sheetContext) {
      final colorScheme = Theme.of(sheetContext).colorScheme;

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitulo.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitulo,
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              ListTile(
                leading: Icon(Icons.fullscreen, color: colorScheme.primary),
                title: const Text("Ver imagem ampliada"),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SaintFullscreenViewer(
                        name: name,
                        subtitulo: subtitulo,
                        heroTag: heroTag,
                        assetPath: assetPath,
                        localPath: localPath,
                        networkUrl: networkUrl,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: colorScheme.primary),
                title: const Text("Compartilhar imagem"),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  SaintImageService.shareSaintImage(
                    context,
                    name: name,
                    subtitulo: subtitulo,
                    assetPath: assetPath,
                    localPath: localPath,
                    networkUrl: networkUrl,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.download, color: colorScheme.primary),
                title: const Text("Salvar imagem"),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  SaintImageService.downloadSaintImage(
                    context,
                    name: name,
                    assetPath: assetPath,
                    localPath: localPath,
                    networkUrl: networkUrl,
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
