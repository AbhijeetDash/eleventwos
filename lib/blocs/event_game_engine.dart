import 'package:eleventwos/enums/_enum_swipe_direction.dart';

abstract class EventGameEngine {}

class EventNewGame extends EventGameEngine {}

class EventMove extends EventGameEngine {
  final SwipeDirection direction;

  EventMove({required this.direction});
}
