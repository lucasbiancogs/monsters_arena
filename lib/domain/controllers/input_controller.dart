import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monsters_arena/domain/controllers/direction_controller.dart';

abstract class InputController {
  /// Handles no key input.
  KeyEventResult noKeyHandle();

  /// Handles the inputed [key].
  KeyEventResult handleKeys(Set<LogicalKeyboardKey> keys);
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
  KeyEventResult handleKeys(Set<LogicalKeyboardKey> keys) {
    final hasKeyMapped = keys.union(_keysFunctionsMap.keys.toSet()).isNotEmpty;

    if (!hasKeyMapped) {
      return KeyEventResult.ignored;
    }

    directionController.onNewMovement();

    for (LogicalKeyboardKey key in keys) {
      _keysFunctionsMap[key]!.call();
    }

    return KeyEventResult.handled;
  }

  Map<LogicalKeyboardKey, VoidCallback> get _keysFunctionsMap => {
        LogicalKeyboardKey.arrowUp: directionController.moveUp,
        LogicalKeyboardKey.arrowDown: directionController.moveDown,
        LogicalKeyboardKey.arrowLeft: directionController.moveLeft,
        LogicalKeyboardKey.arrowRight: directionController.moveRight,
      };
}
