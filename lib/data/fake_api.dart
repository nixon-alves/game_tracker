import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:game_tracker/models/game_search_result.dart';

Future<List<GameSearchResult>> fakeSearchGames(String query) async {
  final String jsonString = await rootBundle.loadString(
    'assets/fake_api_response.json',
  );
  final Map<String, dynamic> data = jsonDecode(jsonString);
  final List results = data['results'];

  return results
      .map((json) => GameSearchResult.fromMap(json))
      .where(
        (game) =>
        query.isEmpty ||
            game.title.toLowerCase().contains(query.toLowerCase()),
      )
      .toList();
}
