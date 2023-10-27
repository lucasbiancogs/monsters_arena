import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monsters_arena/domain/controllers/direction_controller.dart';

abstract class InputController {
  /// Handles no key input.
  KeyEventResult noKeyHandle();

  /// Handles the inputed [key].
  KeyEventResult handleKey(LogicalKeyboardKey key);
}

class KeyboardInputController implements InputController {
  KeyboardInputController({required this.directionController});

  final KeyboardDirectionController directionController;

  @override
  KeyEventResult noKeyHandle() {
    directionController.stop();

    return KeyEventResult.handled;
  }

  @override
  KeyEventResult handleKey(LogicalKeyboardKey key) {
    if (!_keysFunctionsMap.containsKey(key)) {
      return KeyEventResult.ignored;
    }

    _keysFunctionsMap[key]!.call();

    return KeyEventResult.handled;
  }

  Map<LogicalKeyboardKey, VoidCallback> get _keysFunctionsMap => {
        LogicalKeyboardKey.arrowUp: directionController.moveUp,
        LogicalKeyboardKey.arrowDown: directionController.moveDown,
        LogicalKeyboardKey.arrowLeft: directionController.moveLeft,
        LogicalKeyboardKey.arrowRight: directionController.moveRight,
      };
}
