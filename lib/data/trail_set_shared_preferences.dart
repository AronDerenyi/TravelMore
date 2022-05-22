import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TrailSetSharedPreferences {
  final String _key;
  final SharedPreferences _preferences;
  Set<String> _set;

  final StreamController<Set<String>> _changeStream =
      StreamController.broadcast();

  TrailSetSharedPreferences(SharedPreferences preferences, String key)
      : _preferences = preferences,
        _key = key,
        _set = Set.from(preferences.getStringList(key) ?? []);

  List<String> getTrailIds() {
    return _set.toList();
  }

  bool contains(String trailId) {
    return _set.contains(trailId);
  }

  Future<bool> add(String trailId) async {
    var newSet = Set<String>.from(_set);
    if (!newSet.add(trailId)) return false;
    if (!await _preferences.setStringList(_key, newSet.toList())) {
      return false;
    }

    _set = newSet;
    _changeStream.add(newSet);
    return true;
  }

  Future<bool> remove(String trailId) async {
    var newSet = Set<String>.from(_set);
    if (!newSet.remove(trailId)) return false;
    if (!await _preferences.setStringList(_key, newSet.toList())) {
      return false;
    }

    _set = newSet;
    _changeStream.add(newSet);
    return true;
  }

  StreamSubscription<Set<String>> listen(
      void Function(Set<String> event) onData) {
    return _changeStream.stream.listen(onData);
  }
}
