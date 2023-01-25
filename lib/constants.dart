import 'package:flame/components.dart';

const double groundHeight = 32.0;
const int dinoScaling = 10;
const int gravity = 1000;
const int enemyScaling = 10;
int enemySpeed = 7;
const double screenMargin = 15;
Vector2 backgroundSpeed = Vector2(28, 0);
Vector2 groundBackgroundSpeed = Vector2(90, 0);
Vector2 velocityMultiplierDelta = Vector2(1.7, 1.0);
Vector2 groundVelocityMultiplierDelta = Vector2(1.7, 1.0);
