import 'dart:math';

import 'package:dino_run/background.dart';
import 'package:dino_run/constants.dart';
import 'package:dino_run/dino.dart';
import 'package:dino_run/enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

Icon icon = const Icon(Icons.pause_circle_outline);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(MaterialApp(
    home: Scaffold(
      body: GameWidget(
        game: DinoGame(),
        overlayBuilderMap: {
          "PauseGame": (_, DinoGame gameRef) {
            return Pause(gameRef);
          },
        },
      ),
    ),
  ));
}

Widget Pause(DinoGame gameRef) {
  return IconButton(
    onPressed: () {
      if (icon == const Icon(Icons.pause_circle_outline)) {
        DinoGame().pauseGame();
        icon = const Icon(Icons.play_circle_outline_outlined);
      } else {
        DinoGame().resumeGame();
        icon = const Icon(Icons.pause_circle_outline);
      }
    },
    icon: icon,
    color: Colors.white,
    iconSize: 30,
  );
}

class DinoGame extends FlameGame with TapDetector {
  SpriteAnimationComponent dino = SpriteAnimationComponent();
  SpriteAnimationComponent enemy = SpriteAnimationComponent();
  SpriteAnimationComponent enemy2 = SpriteAnimationComponent();

  double yMax = 0.0;
  double speedY = 0.0;
  int score = 2;
  double origDinoY = 0.0;
  late Component background;
  late Component ground;
  late TextComponent scoreText;
  late TextComponent askReset;
  Random random = Random();
  bool isHit = false;

  final Dino _dino = Dino();
  final Enemy _enemy = Enemy();
  final Background _background = Background();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache
        .loadAll(['backgroundMusic.mp3', 'collide.mp3', 'jump.mp3']);
    FlameAudio.play("collide.mp3", volume: 0.0);

    background = await _background.forestBackground();
    ground = await _background.loadGround();
    add(background);
    add(ground);

    dino.x = dino.width;
    dino.y = canvasSize[1] - dino.height - groundHeight + 10;
    origDinoY = dino.y;
    yMax = dino.y;
    add(dino);
    add(enemy);

    scoreText = TextComponent(
      text: score.toString(),
      textRenderer: TextPaint(
        style: const TextStyle(fontFamily: "AudioWide", fontSize: 16),
      ),
    );
    scoreText.position =
        Vector2((canvasSize[0] / 2) - scoreText.width, screenMargin);

    add(scoreText);
    askReset = TextComponent(
      text: "",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: "AudioWide",
          fontSize: 54,
        ),
      ),
    );
    add(askReset);
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    FlameAudio.bgm.play("backgroundMusic.mp3");
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
    if (!isHit) {
      if (dino.y == origDinoY) {
        jumpAnimation();
      }
    } else {
      reset();
    }
  }

  void jumpAnimation() {
    speedY = -470;
    FlameAudio.play("jump.mp3");
  }

  @override
  void update(double dt) async {
    // TODO: implement update
    super.update(dt);
    speedY += gravity * dt;
    dino.y += speedY * dt;

    if (_dino.isOnGround(yMax, dino)) {
      speedY = 0;
      dino.y = yMax;
    }

    enemy.x -= enemySpeed;

    if (enemy.x < -60) {
      repeatEnemy();
    }

    score += (60 * dt).toInt();
    scoreText.text = score.toString();

    if ((dino.x >= enemy.x) &&
        (dino.y == origDinoY) &&
        (dino.x < enemy.x + enemy.width)) {
      FlameAudio.play("collide.mp3");
      pauseGame();
      isHit = true;
      askReset.text = "GAME OVER\nTap anywhere to restart";
      askReset.position = Vector2(
          (canvasSize[0] / 2) - (askReset.width / 2), (canvasSize[1] / 2));
    }
  }

  pauseGame() {
    pauseEngine();
  }

  void resumeGame() {
    resumeEngine();
  }

  void reset() {
    score = 2;
    isHit = false;
    resumeGame();
    repeatEnemy();
    askReset.text = "";
  }

  void repeatEnemy() async {
    enemy.removeFromParent();
    enemy = await _enemy.enemyAnimation();
    enemy.height = enemy.width = canvasSize[0] / enemyScaling;
    enemy.x = enemy.width + canvasSize[0];
    enemy.y = canvasSize[1] - enemy.height - groundHeight + 10;
    add(enemy);
  }
}
