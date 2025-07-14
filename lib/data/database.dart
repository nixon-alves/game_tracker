import 'package:game_tracker/data/game_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'games.db');
  return openDatabase(path, onCreate: (db, version){
    db.execute(GameDao.tableSql);
  }, version: 1,);
}