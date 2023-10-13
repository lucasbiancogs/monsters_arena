import 'package:flame/game.dart';
import 'package:monsters_arena/presentation/characters/character.dart';

class MainGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final character = CharacterComponent();

    add(character);
  }
}
