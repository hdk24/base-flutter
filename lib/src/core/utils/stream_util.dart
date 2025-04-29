import 'dart:async';

/// source: https://github.com/marcojakob/dart-event-bus/blob/master/lib/event_bus.dart
EventBus eventBus = EventBus();

class EventBus {
  final StreamController _streamController;

  StreamController get streamController => _streamController;

  EventBus({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);

  EventBus.customController(StreamController controller)
      : _streamController = controller;

  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  void push(event) {
    streamController.add(event);
  }

  /// This is only in a testing context.
  void destroy() {
    _streamController.close();
  }
}
