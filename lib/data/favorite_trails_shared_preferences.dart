import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_more/domain/repositories/favorite_trails_repository.dart';

import 'trail_set_shared_preferences.dart';

class FavoriteTrailsSharedPreferences implements FavoriteTrailsRepository {
  static const String _key = "favorites";
  final TrailSetSharedPreferences _trailSet;

  FavoriteTrailsSharedPreferences(SharedPreferences preferences)
      : _trailSet = TrailSetSharedPreferences(preferences, _key);

  @override
  Future<List<String>> getFavoriteTrailIds() async => _trailSet.getTrailIds();

  @override
  Future<bool> isFavorite(String trailId) async => _trailSet.contains(trailId);

  @override
  Future<bool> addFavorite(String trailId) async => _trailSet.add(trailId);

  @override
  Future<bool> removeFavorite(String trailId) async =>
      _trailSet.remove(trailId);

  @override
  StreamSubscription<Set<String>> listen(
          void Function(Set<String> event) onData) =>
      _trailSet.listen(onData);
}
