import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:dino_run/dino.dart';

const double groundHeight = 32.0;
const int dinoScaling = 10;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(GameWidget(
    game: MyGame(),
  ));
}

class MyGame extends FlameGame {
  SpriteAnimationComponent dino = SpriteAnimationComponent();

  Future<Component> forestBackground() async {
    return loadParallaxComponent(
      [
        ParallaxImageData("parallax/plx-1.png"),
        ParallaxImageData("parallax/plx-2.png"),
        ParallaxImageData("parallax/plx-3.png"),
        ParallaxImageData("parallax/plx-4.png"),
        ParallaxImageData("parallax/plx-5.png"),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.6, 1.0),
    );
  }

  Future<ParallaxComponent<FlameGame>> loadGround() async {
    return await ParallaxComponent.load(
      [
        ParallaxImageData("parallax/plx-6Grd.png"),
      ],
      fill: LayerFill.none,
      baseVelocity: Vector2(65, 0),
      velocityMultiplierDelta: Vector2(1.6, 1.0),
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(await forestBackground());

    add(await loadGround());

    add(dino);
    Dino().run();
  }

  @override
  void onGameResize(Vector2 canvasSize) async {
    // TODO: implement onGameResize
    super.onGameResize(canvasSize);
    dino = await Dino().idleAnimation();
    dino.height = dino.width = canvasSize[0] / dinoScaling;
    dino.x = dino.width;
    dino.y = canvasSize[1] - dino.height - groundHeight + 10;
  }
}
