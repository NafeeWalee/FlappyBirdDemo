import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_game_loop/components/assets.dart';
import 'package:flame_game_loop/components/pipe.dart';
import 'package:flame_game_loop/game/variables/configuration.dart';
import 'package:flame_game_loop/game/variables/pipe_position.dart';

import '../game/flappy_bird_game.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY = spacing + _random.nextDouble() * (heightMinusGround - spacing);

    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      Pipe(pipePosition: PipePosition.bottom, height: heightMinusGround - (centerY + spacing / 2)),
    ]);
  }

  void updateScore() {
    gameRef.bird.score += 1;
    FlameAudio.play(Assets.point);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if (position.x < -50) {
      removePipes();
      updateScore();
    }

    if (gameRef.isHit) {
      removePipes();
      gameRef.isHit = false;
    }
  }

  void removePipes() {
    removeFromParent();
  }
}
