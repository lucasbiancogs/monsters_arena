import 'dart:math';

abstract class DirectionController {
  /// Indicates the [direction] in radians.
  double get direction;

  /// An 0 to 1 [speedFactor] to the associated [direction].
  ///
  /// If 1 is at full speed, if 0 is stopped.
  double get speedFactor;

  /// A helper to define the how much up and how fast is going.
  double get verticalDirectionFactor => sin(direction) * speedFactor;

  /// A helper to define the how much right and how fast is going.
  double get horizontalDirectionFactor => cos(direction) * speedFactor;
}

class KeyboardDirectionController extends DirectionController {
  KeyboardDirectionController({double speedFactor = 0, double direction = 0})
      : _speedFactor = speedFactor,
        _direction = direction;

  @override
  double get speedFactor => _speedFactor;

  @override
  double get direction => _direction;

  double _speedFactor;

  double _direction;

  void moveRight() {
    _direction = 0;
    _speedFactor = 1;
  }

  void moveLeft() {
    _direction = pi;
    _speedFactor = 1;
  }

  void moveUp() {
    _direction = pi / 2;
    _speedFactor = 1;
  }

  void moveDown() {
    _direction = 3 * pi / 2;
    _speedFactor = 1;
  }

  void stop() {
    _speedFactor = 0;
  }
}
