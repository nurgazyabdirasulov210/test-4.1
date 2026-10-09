import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/base_card.dart';
import '../../core/widgets/base_list_view.dart';
import 'episode.dart';
import 'episodes_bloc.dart';

class EpisodesPage extends StatelessWidget {
  const EpisodesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseListView<EpisodesBloc, Episode>(
      title: 'Эпизоды',
      aspectRatio: 1.2,
      itemBuilder: (e) => BaseCard(
        title: e.name,
        subtitle: e.code,
        caption: e.airDate,
        neonColor: AppColors.neonBlue,
      ),
    );
  }
}
