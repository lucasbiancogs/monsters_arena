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
  KeyboardDirectionController()
      : _speedFactor = 0,
        _xAxisFactor = 0,
        _yAxisFactor = 0;

  @override
  double get speedFactor => _speedFactor;

  @override
  double get direction => atan2(_yAxisFactor, _xAxisFactor);

  double _speedFactor;

  double _xAxisFactor;
  double _yAxisFactor;

  void moveRight() {
    _xAxisFactor = max(_xAxisFactor + 1, 1);
    _speedFactor = 1;
  }

  void moveLeft() {
    _xAxisFactor = max(_xAxisFactor - 1, -1);
    _speedFactor = 1;
  }

  void moveUp() {
    _yAxisFactor = max(_yAxisFactor + 1, 1);
    _speedFactor = 1;
  }

  void moveDown() {
    _yAxisFactor = max(_yAxisFactor - 1, -1);
    _speedFactor = 1;
  }

  void onNewMovement() {
    _xAxisFactor = 0;
    _yAxisFactor = 0;
  }

  void stop() {
    _speedFactor = 0;
  }
}
