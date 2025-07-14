import 'package:game_tracker/data/database.dart';
import 'package:game_tracker/models/game.dart';
import 'package:sqflite/sqflite.dart';

class GameDao {
  static const String tableSql =
      'CREATE TABLE $_tablename('
      '$_title TEXT,'
      '$_image TEXT,'
      '$_rating TEXT,'
      '$_status TEXT,'
      '$_date TEXT)';

  static const String _tablename = 'game_table';
  static const String _title = 'title';
  static const String _image = 'image';
  static const String _rating = 'rating';
  static const String _status = 'status';
  static const String _date = 'date';

  Future<int> save(Game game) async {
    final Database database = await getDatabase();
    var itemExists = await find(game.title);
    Map<String, dynamic> gameMap = game.toMap();

    if (itemExists.isEmpty) {
      return await database.insert(_tablename, gameMap);
    } else {
      return await database.update(
        _tablename,
        gameMap,
        where: '$_title = ?',
        whereArgs: [game.title],
      );
    }
  }

  Future<List<Game>> findAll() async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(_tablename);
    return toList(result);
  }

  Future<List<Game>> find(String mapName) async {
    final Database database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      _tablename,
      where: '$_title = ?',
      whereArgs: [mapName],
    );

    return toList(result);
  }

  List<Game> toList(List<Map<String, dynamic>> mapOfGames) {
    final List<Game> games = [];
    for (Map<String, dynamic> line in mapOfGames) {
      final Game game = Game(
        line[_title],
        line[_image],
        line[_rating],
        line[_status],
        line[_date],
      );
      games.add(game);
    }
    return games;
  }

  Future<int> delete(String mapName) async {
    final Database database = await getDatabase();
    return await database.delete(
      _tablename,
      where: '$_title = ?',
      whereArgs: [mapName],
    );
  }
}
