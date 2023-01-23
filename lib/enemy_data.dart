import 'package:flame/components.dart';

class EnemyData {
  final String path;
  final int start;
  final int end;
  final int amount;
  final Vector2 textureSize;

  EnemyData({
    required this.path,
    required this.start,
    required this.end,
    required this.amount,
    required this.textureSize,
  });
}
