import 'dart:math';

import 'package:flame/components.dart';
import 'package:monsters_arena/domain/controllers/balance_controller.dart';
import 'package:monsters_arena/domain/controllers/direction_controller.dart';
import 'package:monsters_arena/presentation/components/character_asset.dart';
import 'package:monsters_arena/presentation/constants/durations.dart';
import 'package:monsters_arena/presentation/game.dart';

class CharacterComponent extends SpriteAnimationComponent with HasGameRef<MainGame> {
  CharacterComponent({
    required this.directionController,
    required this.balance,
    required this.asset,
  });

  final KeyboardDirectionController directionController;
  final BalanceController balance;
  final CharacterAsset asset;

  /// Save a list of idle animations
  ///
  /// For this component is facing right first and facing left last.
  late final List<SpriteAnimation> _idleAnimations;

  /// Save a list of run animations
  ///
  /// For this component is facing right first and facing left last.
  late final List<SpriteAnimation> _runAnimations;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await _loadAnimations();

    animation = _idleAnimations.first;
    position = Vector2(100, 100);
    size = Vector2(50, 50);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _moveCharacter(dt);
    _animateCharacter();
  }

  /// Moves the player at every frame fot given the [directionController].
  void _moveCharacter(double dt) {
    x = x + (balance.playerSpeed * directionController.horizontalDirectionFactor * dt);
    y = y - (balance.playerSpeed * directionController.verticalDirectionFactor * dt);
  }

  /// Animates the character based on the `direction` and `speedFactor`.
  void _animateCharacter() {
    final horizontalDirection = cos(directionController.direction);
    final animationList = directionController.speedFactor > 0 ? _runAnimations : _idleAnimations;

    animation = horizontalDirection > 0 ? animationList.first : animationList.last;
  }

  Future<void> _loadAnimations() async {
    // Idle animations
    final rightIdleAnimation = asset.idle.createAnimation(
      row: 0,
      stepTime: Durations.spriteSheetStepTime,
      to: 4,
    );
    final leftIdleAnimation = asset.idle.createAnimation(
      row: 1,
      stepTime: Durations.spriteSheetStepTime,
      to: 4,
    );

    _idleAnimations = [rightIdleAnimation, leftIdleAnimation];

    // Run animations
    final rightRunAnimation = asset.run.createAnimation(
      row: 0,
      stepTime: Durations.spriteSheetStepTime,
      to: 6,
    );
    final leftRunAnimation = asset.run
        .createAnimation(
          row: 1,
          stepTime: Durations.spriteSheetStepTime,
          to: 6,
        )
        .reversed();

    _runAnimations = [rightRunAnimation, leftRunAnimation];
  }
}
