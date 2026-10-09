import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BaseNetworkImage extends StatelessWidget {
  const BaseNetworkImage(this.url, {super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
      width: double.infinity,
      loadingBuilder: (_, child, progress) => progress == null
          ? child
          : const Center(
              child: CircularProgressIndicator(color: AppColors.neonGreen),
            ),
      errorBuilder: (_, _, _) => const Center(
        child: Icon(Icons.broken_image, color: AppColors.textSecondary),
      ),
    );
  }
}
