import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Dino extends FlameGame {

  // Future<SpriteAnimation> getIdleAnimation() async {
  //   return SpriteAnimation.fromFrameData(
  //     await images.load("DinoSprites - vita.png"),
  //     SpriteAnimationData.range(
  //       start: 0,
  //       end: 3,
  //       amount: 24,
  //       stepTimes: List<double>.filled(24, 0.1),
  //       textureSize: Vector2(24, 24),
  //     ),
  //   );
  // }
  //
  // Future<SpriteAnimation> getRunAnimation() async {
  //   return SpriteAnimation.fromFrameData(
  //     await images.load("DinoSprites - vita.png"),
  //     SpriteAnimationData.range(
  //       start: 4,
  //       end: 10,
  //       amount: 24,
  //       stepTimes: List<double>.filled(24, 0.1),
  //       textureSize: Vector2(24, 24),
  //     ),
  //   );
  // }
  //
  // Future<SpriteAnimationComponent> getSpriteAnimationComponent() async {
  //   return SpriteAnimationComponent()..animation = await getRunAnimation();
  // }

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

  void run() {
    runAnimation();
  }

  void idle(){
    idleAnimation();
  }
}
