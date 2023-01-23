import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'enemy_data.dart';

enum EnemyType { angryPig, bat, rino }

class Enemy extends FlameGame {
  Map<EnemyType, EnemyData> enemyDetails = {
    EnemyType.angryPig: EnemyData(
      path: "AngryPig/Idle (36x30).png",
      start: 0,
      end: 8,
      amount: 9,
      textureSize: Vector2(36, 30),
    ),
    EnemyType.bat: EnemyData(
      path: "Bat/Flying (46x30).png",
      start: 0,
      end: 6,
      amount: 7,
      textureSize: Vector2(46, 30),
    ),
    EnemyType.rino: EnemyData(
      path: "Rino/Run (52x34).png",
      start: 0,
      end: 5,
      amount: 6,
      textureSize: Vector2(52, 34),
    ),
  };

  Future<SpriteAnimation> setAnim({required EnemyData data}) async {
    return SpriteAnimation.fromFrameData(
      await images.load(data.path),
      SpriteAnimationData.range(
        start: data.start,
        end: data.end,
        amount: data.amount,
        stepTimes: List<double>.filled(data.amount, 0.1),
        textureSize: data.textureSize,
      ),
    );
  }

  Future<SpriteAnimationComponent> enemyAnimation() async {
    return SpriteAnimationComponent()
      ..animation = await setAnim(data: enemyDetails[EnemyType.bat]!);
  }
}
