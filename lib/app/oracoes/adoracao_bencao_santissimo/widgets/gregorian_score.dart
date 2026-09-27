import 'package:flutter/material.dart';

/// Modelo de um elemento musical na pauta gregoriana.
sealed class GregorianElement {
  const GregorianElement();
}

/// Sílaba com uma ou mais notas associadas.
class GregorianSyllable extends GregorianElement {
  final String text;
  final List<GregorianNeume> neumes;
  final bool hasAsterisk;

  const GregorianSyllable(this.text, this.neumes, {this.hasAsterisk = false});
}

/// Barra de divisão litúrgica (compasso gregoriano).
class GregorianBarLine extends GregorianElement {
  final GregorianBarType type;
  const GregorianBarLine(this.type);
}

enum GregorianBarType {
  minima, // pequeno traço superior
  minor, // traço médio (entre linha 2 e 3)
  maior, // traço cruzando as 4 linhas
  finalis, // traço duplo final
}

/// Neuma gregoriano (nota ou componente de neuma).
class GregorianNeume {
  final int pitch;
  final bool isDiamond;
  final bool hasStem;
  final bool hasDot;
  final bool isFlat;

  const GregorianNeume(
    this.pitch, {
    this.isDiamond = false,
    this.hasStem = false,
    this.hasDot = false,
    this.isFlat = false,
  });
}

/// Uma linha completa de pauta gregoriana (sistema de 4 linhas).
class GregorianStaffLine {
  final int clefLine;
  final List<GregorianElement> elements;

  const GregorianStaffLine({this.clefLine = 4, required this.elements});
}

/// Widget expansível que contém a partitura gregoriana via imagem oficial.
class GregorianScoreTile extends StatelessWidget {
  final String title;
  final String mode;
  final String imageAsset;
  final String? initialLetter;
  final List<GregorianStaffLine>? lines;

  const GregorianScoreTile({
    super.key,
    this.title = "Pauta do Canto (Tom Gregoriano)",
    required this.mode,
    required this.imageAsset,
    this.initialLetter,
    this.lines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ExpansionTile(
        leading: Icon(Icons.music_note, color: theme.colorScheme.primary),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        collapsedBackgroundColor: theme.colorScheme.secondaryContainer,
        backgroundColor: theme.colorScheme.secondaryContainer,
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 12.0,
        ),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                theme.colorScheme.onSecondaryContainer,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                imageAsset,
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget que renderiza o desenho vetorial da pauta gregoriana via CustomPainter.
class GregorianChantScore extends StatelessWidget {
  final String mode;
  final String? initialLetter;
  final List<GregorianStaffLine> lines;
  final Color staffColor;
  final Color noteColor;
  final Color textColor;

  const GregorianChantScore({
    super.key,
    required this.mode,
    this.initialLetter,
    required this.lines,
    required this.staffColor,
    required this.noteColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    double maxWidth = 360.0;
    for (final line in lines) {
      double w = 55.0;
      for (final el in line.elements) {
        if (el is GregorianSyllable) {
          final textLen = el.text.length * 8.5;
          final neumesLen = el.neumes.length * 11.0;
          w +=
              (textLen > neumesLen ? textLen : neumesLen) +
              (el.hasAsterisk ? 18.0 : 8.0);
        } else if (el is GregorianBarLine) {
          w += 16.0;
        }
      }
      if (w > maxWidth) {
        maxWidth = w;
      }
    }

    const double systemHeight = 72.0;
    final double totalHeight = lines.length * systemHeight + 20.0;

    return CustomPaint(
      size: Size(maxWidth + 30.0, totalHeight),
      painter: _GregorianPainter(
        mode: mode,
        initialLetter: initialLetter,
        lines: lines,
        staffColor: staffColor,
        noteColor: noteColor,
        textColor: textColor,
        systemHeight: systemHeight,
      ),
    );
  }
}

class _GregorianPainter extends CustomPainter {
  final String mode;
  final String? initialLetter;
  final List<GregorianStaffLine> lines;
  final Color staffColor;
  final Color noteColor;
  final Color textColor;
  final double systemHeight;

  _GregorianPainter({
    required this.mode,
    this.initialLetter,
    required this.lines,
    required this.staffColor,
    required this.noteColor,
    required this.textColor,
    required this.systemHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final staffPaint = Paint()
      ..color = staffColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final notePaint = Paint()
      ..color = noteColor
      ..style = PaintingStyle.fill;

    final noteStrokePaint = Paint()
      ..color = noteColor
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const double lineSpacing = 8.0;
    const double noteSize = 6.0;

    for (int l = 0; l < lines.length; l++) {
      final line = lines[l];
      final double systemTop = l * systemHeight + 16.0;
      final double staffBottom = systemTop + 3 * lineSpacing;

      for (int i = 0; i < 4; i++) {
        final double y = staffBottom - (i * lineSpacing);
        canvas.drawLine(Offset(10, y), Offset(size.width - 10, y), staffPaint);
      }

      double x = 16.0;

      if (l == 0) {
        final modePainter = TextPainter(
          text: TextSpan(
            text: "$mode ",
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: staffColor,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        modePainter.paint(canvas, Offset(x, systemTop - 12.0));

        if (initialLetter != null && initialLetter!.isNotEmpty) {
          final initPainter = TextPainter(
            text: TextSpan(
              text: initialLetter!,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: staffColor,
                fontFamily: 'serif',
              ),
            ),
            textDirection: TextDirection.ltr,
          )..layout();
          initPainter.paint(canvas, Offset(x, systemTop + 2.0));
          x += initPainter.width + 4.0;
        }
      }

      final double clefY = staffBottom - ((line.clefLine - 1) * lineSpacing);
      _drawCClef(canvas, x, clefY, notePaint);
      x += 18.0;

      for (final el in line.elements) {
        if (el is GregorianBarLine) {
          x += 6.0;
          switch (el.type) {
            case GregorianBarType.minima:
              canvas.drawLine(
                Offset(x, staffBottom - 3 * lineSpacing),
                Offset(x, staffBottom - 3 * lineSpacing + 4.0),
                staffPaint..strokeWidth = 1.2,
              );
              break;
            case GregorianBarType.minor:
              canvas.drawLine(
                Offset(x, staffBottom - 2 * lineSpacing),
                Offset(x, staffBottom - lineSpacing),
                staffPaint..strokeWidth = 1.2,
              );
              break;
            case GregorianBarType.maior:
              canvas.drawLine(
                Offset(x, staffBottom - 3 * lineSpacing),
                Offset(x, staffBottom),
                staffPaint..strokeWidth = 1.2,
              );
              break;
            case GregorianBarType.finalis:
              canvas.drawLine(
                Offset(x, staffBottom - 3 * lineSpacing),
                Offset(x, staffBottom),
                staffPaint..strokeWidth = 1.0,
              );
              canvas.drawLine(
                Offset(x + 3.0, staffBottom - 3 * lineSpacing),
                Offset(x + 3.0, staffBottom),
                staffPaint..strokeWidth = 2.0,
              );
              x += 3.0;
              break;
          }
          x += 10.0;
        } else if (el is GregorianSyllable) {
          final textPainter = TextPainter(
            text: TextSpan(
              text: el.text,
              style: TextStyle(
                fontSize: 11.5,
                color: textColor,
                fontFamily: 'serif',
              ),
            ),
            textDirection: TextDirection.ltr,
          )..layout();

          final double textWidth = textPainter.width;
          final double neumesWidth = el.neumes.length * (noteSize + 3.0);
          final double itemWidth = textWidth > neumesWidth
              ? textWidth
              : neumesWidth;

          double noteX = x + (itemWidth - neumesWidth) / 2;
          for (final n in el.neumes) {
            final double noteY = staffBottom - (n.pitch * (lineSpacing / 2));

            if (n.isFlat) {
              _drawFlat(canvas, noteX - 5.0, noteY, notePaint);
            }

            if (n.isDiamond) {
              final path = Path()
                ..moveTo(noteX + noteSize / 2, noteY - noteSize / 2)
                ..lineTo(noteX + noteSize, noteY)
                ..lineTo(noteX + noteSize / 2, noteY + noteSize / 2)
                ..lineTo(noteX, noteY)
                ..close();
              canvas.drawPath(path, notePaint);
            } else {
              final rect = Rect.fromCenter(
                center: Offset(noteX + noteSize / 2, noteY),
                width: noteSize,
                height: noteSize,
              );
              canvas.drawRect(rect, notePaint);

              if (n.hasStem) {
                canvas.drawLine(
                  Offset(noteX + noteSize, noteY - noteSize / 2),
                  Offset(noteX + noteSize, noteY + 9.0),
                  noteStrokePaint,
                );
              }
            }

            if (n.hasDot) {
              canvas.drawCircle(
                Offset(noteX + noteSize + 3.0, noteY),
                1.3,
                notePaint,
              );
            }

            noteX += noteSize + 3.0;
          }

          final double textX = x + (itemWidth - textWidth) / 2;
          textPainter.paint(canvas, Offset(textX, staffBottom + 4.0));

          if (el.hasAsterisk) {
            final astPainter = TextPainter(
              text: TextSpan(
                text: " *",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: staffColor,
                ),
              ),
              textDirection: TextDirection.ltr,
            )..layout();
            astPainter.paint(
              canvas,
              Offset(x + itemWidth + 2.0, staffBottom + 3.0),
            );
            x += astPainter.width + 4.0;
          }

          x += itemWidth + 6.0;
        }
      }
    }
  }

  void _drawCClef(Canvas canvas, double x, double y, Paint paint) {
    final strokePaint = Paint()
      ..color = paint.color
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(x, y - 6.0), Offset(x, y + 6.0), strokePaint);

    final path = Path()
      ..moveTo(x, y - 5.0)
      ..cubicTo(x + 5.0, y - 5.0, x + 5.0, y - 1.0, x + 2.0, y - 0.5)
      ..lineTo(x + 4.5, y)
      ..lineTo(x + 2.0, y + 0.5)
      ..cubicTo(x + 5.0, y + 1.0, x + 5.0, y + 5.0, x, y + 5.0);

    canvas.drawPath(path, strokePaint);

    canvas.drawRect(Rect.fromLTWH(x + 2.0, y - 5.5, 2.5, 2.5), paint);
    canvas.drawRect(Rect.fromLTWH(x + 2.0, y + 3.0, 2.5, 2.5), paint);
  }

  void _drawFlat(Canvas canvas, double x, double y, Paint paint) {
    final strokePaint = Paint()
      ..color = paint.color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(x, y - 6.0), Offset(x, y + 2.0), strokePaint);
    final oval = Rect.fromLTWH(x, y - 2.5, 3.5, 4.5);
    canvas.drawArc(oval, -1.5, 3.14, false, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _GregorianPainter oldDelegate) {
    return oldDelegate.staffColor != staffColor ||
        oldDelegate.noteColor != noteColor ||
        oldDelegate.textColor != textColor ||
        oldDelegate.lines != lines;
  }
}
