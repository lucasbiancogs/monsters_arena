import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:monsters_arena/domain/controllers/balance_controller.dart';
import 'package:monsters_arena/domain/controllers/direction_controller.dart';
import 'package:monsters_arena/presentation/constants/dimensions.dart';
import 'package:monsters_arena/presentation/constants/durations.dart';
import 'package:monsters_arena/presentation/constants/sprites.dart';
import 'package:monsters_arena/presentation/game.dart';

class CharacterComponent extends SpriteAnimationComponent with HasGameRef<MainGame> {
  CharacterComponent({
    required this.directionController,
    required this.balance,
  });

  final KeyboardDirectionController directionController;
  final BalanceController balance;

  // TODO(lucasbiancogs): Try to refactor this
  late final List<SpriteAnimation> idleAnimations;
  late final List<SpriteAnimation> runAnimations;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await _loadAnimations();

    animation = idleAnimations.first;
    position = Vector2(100, 100);
    size = Vector2(50, 50);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _moveCharacter(dt);
    _animateCharacter();
  }

  Future<void> _loadAnimations() async {
    // Idle animations
    final idleAsset = await game.images.load(Sprites.fishIdle);
    final rightIdleAnimation = SpriteSheet(
      image: idleAsset,
      srcSize: Vector2(Dimensions.sheetSize, Dimensions.sheetSize),
    ).createAnimation(
      row: 0,
      stepTime: Durations.spriteSheetStepTime,
      to: 4,
    );
    final leftIdleAnimation = SpriteSheet(
      image: idleAsset,
      srcSize: Vector2(Dimensions.sheetSize, Dimensions.sheetSize),
    ).createAnimation(
      row: 1,
      stepTime: Durations.spriteSheetStepTime,
      to: 4,
    );

    idleAnimations = [rightIdleAnimation, leftIdleAnimation];

    // Run animations
    final runAsset = await game.images.load(Sprites.fishRun);
    final rightRunAnimation = SpriteSheet(
      image: runAsset,
      srcSize: Vector2(Dimensions.sheetSize, Dimensions.sheetSize),
    ).createAnimation(
      row: 0,
      stepTime: Durations.spriteSheetStepTime,
      to: 6,
    );
    final leftRunAnimation = SpriteSheet(
      image: runAsset,
      srcSize: Vector2(Dimensions.sheetSize, Dimensions.sheetSize),
    )
        .createAnimation(
          row: 1,
          stepTime: Durations.spriteSheetStepTime,
          to: 6,
        )
        .reversed();

    runAnimations = [rightRunAnimation, leftRunAnimation];
  }

  /// Moves the player at every frame fot given the [directionController].
  void _moveCharacter(double dt) {
    x = x + (balance.playerSpeed * directionController.horizontalDirectionFactor * dt);
    y = y - (balance.playerSpeed * directionController.verticalDirectionFactor * dt);
  }

  /// Animates the character based on the `direction` and `speedFactor`.
  void _animateCharacter() {
    final horizontalDirection = cos(directionController.direction);
    final animationList = directionController.speedFactor > 0 ? runAnimations : idleAnimations;

    animation = horizontalDirection > 0 ? animationList.first : animationList.last;
  }
}
