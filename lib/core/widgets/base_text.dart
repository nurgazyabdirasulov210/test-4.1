import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

/// Единый текстовый виджет приложения (шрифт Orbitron).
/// Меняйте размер/цвет/вес через параметры либо правьте дефолты здесь.
class BaseText extends StatelessWidget {
  const BaseText(
    this.text, {
    super.key,
    this.size = 14,
    this.color = AppColors.textPrimary,
    this.weight = FontWeight.w600,
    this.maxLines,
    this.align,
  });

  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final int? maxLines;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: align,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      style: GoogleFonts.orbitron(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
    );
  }
}
