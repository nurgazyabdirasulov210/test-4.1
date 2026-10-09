import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/list_bloc.dart';
import '../theme/app_colors.dart';
import 'base_button.dart';
import 'base_text.dart';

/// Базовый экран: заголовок, кнопка сортировки, Grid на 2 колонки.
class BaseListView<B extends ListBloc<T>, T> extends StatelessWidget {
  const BaseListView({
    super.key,
    required this.title,
    required this.itemBuilder,
    this.aspectRatio = 0.75,
  });

  final String title;
  final Widget Function(T item) itemBuilder;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: BaseText(title, size: 20, color: AppColors.neonGreen),
        actions: [
          BlocBuilder<B, ListState<T>>(
            builder: (context, state) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: BaseButton(
                label: state.ascending ? 'А-Я' : 'Я-А',
                icon: state.ascending
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                onPressed: state.status == ListStatus.success
                    ? () => context.read<B>().add(ListSortToggled())
                    : null,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<B, ListState<T>>(
        builder: (context, state) {
          switch (state.status) {
            case ListStatus.loading:
              return const Center(
                child: CircularProgressIndicator(color: AppColors.neonGreen),
              );
            case ListStatus.failure:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BaseText('Ошибка загрузки', color: Colors.redAccent),
                    const SizedBox(height: 12),
                    BaseButton(
                      label: 'Повторить',
                      icon: Icons.refresh,
                      onPressed: () => context.read<B>().add(ListLoaded()),
                    ),
                  ],
                ),
              );
            case ListStatus.success:
              return GridView.builder(
                padding: const EdgeInsets.all(AppSizes.padding),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: state.items.length,
                itemBuilder: (_, i) => itemBuilder(state.items[i]),
              );
          }
        },
      ),
    );
  }
}
