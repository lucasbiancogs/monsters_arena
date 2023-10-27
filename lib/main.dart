import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:monsters_arena/domain/controllers/input_controller.dart';
import 'package:monsters_arena/domain/controllers/direction_controller.dart';
import 'package:monsters_arena/presentation/game.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final directionController = KeyboardDirectionController();
    final inputController = KeyboardInputController(directionController: directionController);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(
          game: MainGame(directionController: directionController, inputController: inputController),
        ),
      ),
    );
  }
}
