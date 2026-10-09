import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'base_container.dart';
import 'base_network_image.dart';
import 'base_text.dart';

/// Универсальная неоновая карточка для сетки. Картинка опциональна.
class BaseCard extends StatelessWidget {
  const BaseCard({
    super.key,
    required this.title,
    this.subtitle,
    this.caption,
    this.imageUrl,
    this.neonColor = AppColors.neonGreen,
  });

  final String title;
  final String? subtitle;
  final String? caption;
  final String? imageUrl;
  final Color neonColor;

  @override
  Widget build(BuildContext context) {
    final text = Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(title, size: 14, maxLines: 2),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            BaseText(subtitle!,
                size: 11,
                color: neonColor,
                weight: FontWeight.w500,
                maxLines: 2),
          ],
          if (caption != null) ...[
            const SizedBox(height: 2),
            BaseText(caption!,
                size: 10,
                color: AppColors.textSecondary,
                weight: FontWeight.w400,
                maxLines: 2),
          ],
        ],
      ),
    );

    return BaseContainer(
      neonColor: neonColor,
      child: imageUrl == null
          ? Center(child: text)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: BaseNetworkImage(imageUrl!)),
                text,
              ],
            ),
    );
  }
}
