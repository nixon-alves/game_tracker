import 'package:flutter_test/flutter_test.dart';
import 'package:game_tracker/models/game.dart';

void main(){
  test('Game can be converted to and from a Map correctly', () {
    final game = Game('Hollow Knight', 'url', '4.5', 'Finalizado', '10/10/2024');
    final map = game.toMap();
    final newGame = Game.fromMap(map);

    expect(newGame.title, equals(game.title));
    expect(newGame.image, equals(game.image));
    expect(newGame.rating, equals(game.rating));
    expect(newGame.status, equals(game.status));
    expect(newGame.date, equals(game.date));
  });
}