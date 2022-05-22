import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/favorite_trails_bloc.dart';
import 'package:travel_more/bloc/featured_trails_bloc.dart';
import 'package:travel_more/bloc/discover_bloc.dart';
import 'package:travel_more/data/featured_trails_repository_firestore.dart';
import 'package:travel_more/data/region_repository_firestore.dart';
import 'package:travel_more/view/screens/main/main_navigation_bar.dart';
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
    var mediaQuery = MediaQuery.of(context);
    var newMediaQuery = mediaQuery.copyWith(
      padding: EdgeInsets.only(
        left: mediaQuery.padding.left,
        top: mediaQuery.padding.top,
        right: mediaQuery.padding.right,
        bottom: mediaQuery.padding.bottom + 68,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedTrailsBloc()..add(LoadFeaturedEvent()),
        ),
        BlocProvider(
          create: (context) => FavoriteTrailsBloc()..add(LoadFavoritesEvent()),
        ),
        BlocProvider(
          create: (context) => DiscoverBloc()..add(LoadDiscoverEvent()),
        ),
      ],
      child: Material(
        child: Stack(
          children: [
            Positioned.fill(
              child: MediaQuery(
                data: newMediaQuery,
                child: const [
                  FeaturedScreen(),
                  DiscoverScreen(),
                  FavoritesScreen()
                ][_selectedTab],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: SafeArea(
                  child: MainNavigationBar(
                    selectedIndex: _selectedTab,
                    onSelected: (selected) => setState(
                      () => _selectedTab = selected,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
