import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:monsters_arena/presentation/components/character_asset.dart';
import 'package:monsters_arena/presentation/constants/dimensions.dart';
import 'package:monsters_arena/presentation/constants/sprites.dart';

class AssetManager {
  AssetManager(this.game);

  final FlameGame game;
  late final CharacterAsset character;

  Future<void> loadSprites() async {
    final spriteSheetsResult = await Future.wait(Sprites.sprites.map(
      (spriteName) => _loadSprite(spriteName),
    ));

    final spriteSheetMap = Map.fromEntries(spriteSheetsResult);

    character = CharacterAsset(idle: spriteSheetMap[Sprites.fishIdle]!, run: spriteSheetMap[Sprites.fishRun]!);
  }

  Future<MapEntry<String, SpriteSheet>> _loadSprite(String spriteName) async {
    final sprite = await game.images.load(Sprites.spritePath(spriteName));

    final spriteSheet = SpriteSheet(
      image: sprite,
      srcSize: Vector2(Dimensions.sheetSize, Dimensions.sheetSize),
    );

    return MapEntry(spriteName, spriteSheet);
  }
}
