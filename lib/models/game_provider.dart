import 'package:flutter/material.dart';
import 'package:game_tracker/data/game_dao.dart';
import 'package:game_tracker/models/game.dart';

class GameProvider extends ChangeNotifier {
  List<Game> _games = [];

  List<Game> get games => _games;

  Future<void> loadGames() async {
    _games = await GameDao().findAll();
    notifyListeners();
  }

  Future<void> addOrUpdateGames(Game game) async {
    await GameDao().save(game);
    await loadGames();
  }

  Future<void> removeGame(String title) async {
    await GameDao().delete(title);
    await loadGames();
  }
}