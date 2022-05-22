import 'dart:async';

abstract class CompletedTrailsRepository {
  Future<List<String>> getCompletedTrailIds();
  Future<bool> isCompleted(String trailId);
  Future<bool> addCompleted(String trailId);
  Future<bool> removeCopmleted(String trailId);
  StreamSubscription<Set<String>> listen(void Function(Set<String> event) onData);
}
