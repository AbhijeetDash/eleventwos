import 'dart:math';

class UtilsGame {
  static int randomInt(int min, int max) {
    return min + (max - min) * (100 * Random().nextDouble()).toInt() ~/ 100;
  }
}
