import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:monsters_arena/domain/controllers/direction_controller.dart';
import 'package:monsters_arena/presentation/constants/dimensions.dart';
import 'package:monsters_arena/presentation/constants/durations.dart';
import 'package:monsters_arena/presentation/constants/sprites.dart';
import 'package:monsters_arena/presentation/game.dart';

class CharacterComponent extends SpriteAnimationComponent with HasGameRef<MainGame> {
  CharacterComponent({
    required this.direction,
  });

  final KeyboardDirectionController direction;
  final double playerSpeed = 100;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Maybe this should come from the game as a dependency?
    final characterAsset = await game.images.load(Sprites.fishIdle);
    final spriteSheet = SpriteSheet(
      image: characterAsset,
      srcSize: Vector2(Dimensions.sheetSize, Dimensions.sheetSize),
    );
    final idleCharecterAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: Durations.spriteSheetStepTime,
      to: 4,
    );

    animation = idleCharecterAnimation;
    position = Vector2(100, 100);
    size = Vector2(32, 32);
  }

  @override
  void update(double dt) {
    super.update(dt);

    movePlayer(dt);
  }

  /// Moves the player at every frame fot given the [direction].
  void movePlayer(double dt) {
    x = x + (playerSpeed * direction.horizontalDirectionFactor * dt);
    y = y - (playerSpeed * direction.verticalDirectionFactor * dt);
  }
}
