import 'dart:async';

abstract class FavoriteTrailsRepository {
  Future<Set<String>> getFavoriteTrailIds();
  Future<bool> isFavorite(String trailId);
  Future<bool> addFavorite(String trailId);
  Future<bool> removeFavorite(String trailId);
  StreamSubscription<Set<String>> listen(void Function(Set<String> event) onData);
}
