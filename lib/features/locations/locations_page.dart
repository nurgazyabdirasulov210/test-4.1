import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/base_card.dart';
import '../../core/widgets/base_list_view.dart';
import 'location.dart';
import 'locations_bloc.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseListView<LocationsBloc, Location>(
      title: 'Локации',
      aspectRatio: 1.2,
      itemBuilder: (l) => BaseCard(
        title: l.name,
        subtitle: l.type,
        caption: l.dimension,
        neonColor: AppColors.neonPink,
      ),
    );
  }
}
