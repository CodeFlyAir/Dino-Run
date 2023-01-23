import 'package:dino_run/background.dart';
import 'package:dino_run/constants.dart';
import 'package:dino_run/dino.dart';
import 'package:dino_run/enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(GameWidget(
    game: Game(),
  ));
}

class Game extends FlameGame with TapDetector {
  SpriteAnimationComponent dino = SpriteAnimationComponent();
  SpriteAnimationComponent enemy = SpriteAnimationComponent();

  double yMax = 0.0;
  double jumpKey = 0.0;
  double speedY = 0.0;
  int score = 0;
  late TextComponent scoreText;

  final Dino _dino = Dino();
  final Enemy _enemy = Enemy();
  final Background _background = Background();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(await _background.forestBackground());

    add(await _background.loadGround());

    dino.x = dino.width;
    dino.y = canvasSize[1] - dino.height - groundHeight + 10;
    yMax = dino.y;

    scoreText = TextComponent(text: score.toString());
    scoreText.position =
        Vector2((canvasSize[0] / 2) - scoreText.width, screenMargin);
    add(enemy);
    add(dino);
    add(scoreText);
  }

  @override
  void onGameResize(Vector2 canvasSize) async {
    // TODO: implement onGameResize
    super.onGameResize(canvasSize);
    dino = await _dino.runAnimation();
    dino.height = dino.width = canvasSize[0] / dinoScaling;

    enemy = await _enemy.enemyAnimation();
    enemy.height = enemy.width = canvasSize[0] / enemyScaling;

    enemy.x = enemy.width + canvasSize[0];
    enemy.y = canvasSize[1] - enemy.height - groundHeight + 10;
  }

  @override
  void onTap() async {
    // TODO: implement onTap
    super.onTap();
    jumpAnimation();
  }

  void jumpAnimation() {
    speedY = -450;
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    speedY += gravity * dt;
    dino.y += speedY * dt;

    if (_dino.isOnGround(yMax, dino)) {
      speedY = 0;
      dino.y = yMax;
    }

    enemy.x -= speed;

    if (enemy.x < -60) {
      enemy.x = canvasSize[0];
    }

    score += (60 * dt).toInt();
    scoreText.text = score.toString();
  }
}
