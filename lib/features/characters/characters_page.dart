import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/base_card.dart';
import '../../core/widgets/base_list_view.dart';
import 'character.dart';
import 'characters_bloc.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseListView<CharactersBloc, Character>(
      title: 'Персонажи',
      aspectRatio: 0.72,
      itemBuilder: (c) => BaseCard(
        title: c.name,
        subtitle: c.species,
        caption: c.status,
        imageUrl: c.image,
        neonColor: switch (c.status) {
          'Alive' => AppColors.neonGreen,
          'Dead' => AppColors.neonPink,
          _ => AppColors.neonBlue,
        },
      ),
    );
  }
}
