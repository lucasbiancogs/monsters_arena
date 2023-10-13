import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:monsters_arena/presentation/game.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(
          game: MainGame(),
        ),
      ),
    );
  }
}
