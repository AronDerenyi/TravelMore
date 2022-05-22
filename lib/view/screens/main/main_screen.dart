import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: const [
        FeaturedScreen(),
        DiscoverScreen(),
        FavoritesScreen()
      ][_selectedTab],
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
    );
  }
}
