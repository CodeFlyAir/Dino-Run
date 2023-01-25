import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'enemy_data.dart';

enum EnemyType { angryPig, bat, rino }

class Enemy extends FlameGame {
  Map<int, EnemyData> enemyDetails = {
    1: EnemyData(
      path: "AngryPig/Idle (36x30).png",
      start: 0,
      end: 8,
      amount: 9,
      textureSize: Vector2(36, 30),
    ),
    2: EnemyData(
      path: "Bat/Flying (46x30).png",
      start: 0,
      end: 6,
      amount: 7,
      textureSize: Vector2(46, 30),
    ),
    3: EnemyData(
      path: "Rino/Run (52x34).png",
      start: 0,
      end: 5,
      amount: 6,
      textureSize: Vector2(52, 34),
    ),
  };

  Timer timer = Timer(
    4,
    repeat: true,
  );

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
    int random = Random().nextInt(3) + 1;
    return SpriteAnimationComponent()
      ..animation = await setAnim(data: enemyDetails[random]!);
  }
}
