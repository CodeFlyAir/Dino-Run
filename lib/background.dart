import 'package:dino_run/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';

class Background extends FlameGame {
  Future<Component> forestBackground() async {
    return await loadParallaxComponent(
      [
        ParallaxImageData("parallax/plx-1.png"),
        ParallaxImageData("parallax/plx-2.png"),
        ParallaxImageData("parallax/plx-3.png"),
        ParallaxImageData("parallax/plx-4.png"),
        ParallaxImageData("parallax/plx-5.png"),
      ],
      baseVelocity: backgroundSpeed,
      velocityMultiplierDelta: velocityMultiplierDelta,
    );
  }

  Future<ParallaxComponent<FlameGame>> loadGround() async {
    return await ParallaxComponent.load(
      [
        ParallaxImageData("parallax/plx-6Grd.png"),
      ],
      fill: LayerFill.none,
      baseVelocity: groundBackgroundSpeed,
      velocityMultiplierDelta: groundVelocityMultiplierDelta,
    );
  }
}
