import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_game_loop/components/assets.dart';
import 'package:flame_game_loop/game/flappy_bird_game.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame>{
  Background(); //constructor

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Assets.backGround);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
