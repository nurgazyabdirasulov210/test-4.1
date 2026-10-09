import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Базовый контейнер: скругление 24 и неоновая подсветка через BoxShadow.
class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    required this.child,
    this.neonColor = AppColors.neonGreen,
    this.padding,
    this.radius = AppSizes.cardRadius,
  });

  final Widget child;
  final Color neonColor;
  final EdgeInsetsGeometry? padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: neonColor.withValues(alpha: 0.8), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: neonColor.withValues(alpha: 0.55),
            blurRadius: 14,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}
