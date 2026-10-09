import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/list_bloc.dart';
import 'core/network/api_client.dart';
import 'core/theme/app_theme.dart';
import 'features/characters/characters_bloc.dart';
import 'features/characters/characters_page.dart';
import 'features/characters/characters_repository.dart';
import 'features/episodes/episodes_bloc.dart';
import 'features/episodes/episodes_page.dart';
import 'features/episodes/episodes_repository.dart';
import 'features/locations/locations_bloc.dart';
import 'features/locations/locations_page.dart';
import 'features/locations/locations_repository.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiClient();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              CharactersBloc(CharactersRepository(api))..add(ListLoaded()),
        ),
        BlocProvider(
          create: (_) =>
              LocationsBloc(LocationsRepository(api))..add(ListLoaded()),
        ),
        BlocProvider(
          create: (_) =>
              EpisodesBloc(EpisodesRepository(api))..add(ListLoaded()),
        ),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const HomeShell(),
      ),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _pages = [CharactersPage(), LocationsPage(), EpisodesPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person), label: 'Персонажи'),
          NavigationDestination(icon: Icon(Icons.public), label: 'Локации'),
          NavigationDestination(icon: Icon(Icons.tv), label: 'Эпизоды'),
        ],
      ),
    );
  }
}
