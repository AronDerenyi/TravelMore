import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_more/domain/repositories/completed_trails_repository.dart';

import 'trail_set_shared_preferences.dart';

class CompletedTrailsSharedPreferences implements CompletedTrailsRepository {
  static const String _key = "completed";
  final TrailSetSharedPreferences _trailSet;

  CompletedTrailsSharedPreferences(SharedPreferences preferences)
      : _trailSet = TrailSetSharedPreferences(preferences, _key);

  @override
  Future<Set<String>> getCompletedTrailIds() async => _trailSet.getTrailIds();

  @override
  Future<bool> isCompleted(String trailId) async => _trailSet.contains(trailId);

  @override
  Future<bool> addCompleted(String trailId) async => _trailSet.add(trailId);

  @override
  Future<bool> removeCopmleted(String trailId) async =>
      _trailSet.remove(trailId);

  @override
  StreamSubscription<Set<String>> listen(
          void Function(Set<String> event) onData) =>
      _trailSet.listen(onData);
}
