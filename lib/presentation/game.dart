import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monsters_arena/domain/controllers/input_controller.dart';
import 'package:monsters_arena/domain/controllers/direction_controller.dart';
import 'package:monsters_arena/presentation/components/character_component.dart';

class MainGame extends FlameGame with KeyboardEvents {
  MainGame({required this.inputController, required this.directionController});

  final KeyboardInputController inputController;
  final KeyboardDirectionController directionController;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final character = CharacterComponent(direction: directionController);

    add(character);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final keyPressing = keysPressed.isNotEmpty;

    if (!keyPressing) {
      return inputController.noKeyHandle();
    }

    final lastKeyPressed = keysPressed.last;
    return inputController.handleKey(lastKeyPressed);
  }
}
