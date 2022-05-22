import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/favorite_trails_bloc.dart';
import 'package:travel_more/bloc/featured_trails_bloc.dart';
import 'package:travel_more/bloc/regions_bloc.dart';
import 'package:travel_more/data/featured_trails_repository_firestore.dart';
import 'package:travel_more/data/region_repository_firestore.dart';
import 'discover/discover_screen.dart';
import 'favorites/favorites_screen.dart';
import 'featured/featured_screen.dart';

class MainScreen extends StatefulWidget {
  final int startingTab;

  const MainScreen({Key? key, this.startingTab = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.startingTab;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedTrailsBloc()..add(LoadTrailsEvent()),
        ),
        BlocProvider(
          create: (context) => FavoriteTrailsBloc()..add(LoadFavoritesEvent()),
        ),
        BlocProvider(
          create: (context) => RegionsBloc()..add(LoadRegionsEvent()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: const [
            FeaturedScreen(),
            DiscoverScreen(),
            FavoritesScreen()
          ][_selectedTab],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: 'Featured',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ],
          currentIndex: _selectedTab,
          onTap: (selected) {
            setState(() {
              _selectedTab = selected;
            });
          },
        ),
      ),
    );
  }
}
