import 'package:flame/sprite.dart';

class CharacterAsset {
  CharacterAsset({required this.idle, required this.run});

  final SpriteSheet idle;
  final SpriteSheet run;
}
