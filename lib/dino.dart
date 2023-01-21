import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Dino extends FlameGame {
  Future<SpriteAnimation> setAnim(
      {required String path, required int start, required int end}) async {
    return SpriteAnimation.fromFrameData(
      await images.load(path),
      SpriteAnimationData.range(
        start: start,
        end: end,
        amount: 24,
        stepTimes: List<double>.filled(24, 0.1),
        textureSize: Vector2(24, 24),
      ),
    );
  }

  Future<SpriteAnimationComponent> runAnimation() async {
    return SpriteAnimationComponent()
      ..animation =
          await setAnim(path: "DinoSprites - vita.png", start: 4, end: 10);
  }

  Future<SpriteAnimationComponent> idleAnimation() async {
    return SpriteAnimationComponent()
      ..animation =
          await setAnim(path: "DinoSprites - vita.png", start: 0, end: 3);
  }

  Future<SpriteAnimationComponent> kickAnimation() async {
    return SpriteAnimationComponent()
      ..animation =
          await setAnim(path: "DinoSprites - vita.png", start: 11, end: 13);
  }

  Future<SpriteAnimationComponent> hitAnimation() async {
    return SpriteAnimationComponent()
      ..animation =
          await setAnim(path: "DinoSprites - vita.png", start: 14, end: 16);
  }

  Future<SpriteAnimationComponent> sprintAnimation() async {
    return SpriteAnimationComponent()
      ..animation =
          await setAnim(path: "DinoSprites - vita.png", start: 17, end: 23);
  }

  void run() {
    runAnimation();
  }

  void idle() {
    idleAnimation();
  }

  bool isOnGround(double yMax, SpriteAnimationComponent dino) =>
      (dino.y > yMax);
}
