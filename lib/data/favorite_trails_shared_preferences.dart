import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_more/domain/repositories/favorite_trails_repository.dart';

class FavoriteTrailsSharedPreferences implements FavoriteTrailsRepository {
  static const String key = "favorites";
  final SharedPreferences _preferences;
  Set<String> _favorites;

  final StreamController<Set<String>> _changeStream =
      StreamController.broadcast();

  FavoriteTrailsSharedPreferences(SharedPreferences preferences)
      : _preferences = preferences,
        _favorites = Set.from(preferences.getStringList(key) ?? []);

  @override
  Future<List<String>> getFavoriteTrailIds() async {
    return _favorites.toList();
  }

  @override
  Future<bool> isFavorite(String trailId) async {
    return _favorites.contains(trailId);
  }

  @override
  Future<bool> addFavorite(String trailId) async {
    var newFavorites = Set<String>.from(_favorites);
    if (!newFavorites.add(trailId)) return false;
    if (!await _preferences.setStringList(key, newFavorites.toList())) {
      return false;
    }

    _favorites = newFavorites;
    _changeStream.add(newFavorites);
    return true;
  }

  @override
  Future<bool> removeFavorite(String trailId) async {
    var newFavorites = Set<String>.from(_favorites);
    if (!newFavorites.remove(trailId)) return false;
    if (!await _preferences.setStringList(key, newFavorites.toList())) {
      return false;
    }

    _favorites = newFavorites;
    _changeStream.add(newFavorites);
    return true;
  }
  
  @override
  StreamSubscription<Set<String>> listen(void Function(Set<String> event) onData) {
    return _changeStream.stream.listen(onData);
  }
}
