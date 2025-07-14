import 'package:flutter/material.dart';
import 'package:game_tracker/components/game_card.dart';
import 'package:game_tracker/models/game_provider.dart';
import 'package:game_tracker/models/theme_provider.dart';
import 'package:game_tracker/screens/search_screen.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, provider, _) {
        final games = provider.games;
        return Scaffold(
          appBar: AppBar(
            title: Text("Lista de Jogos",),
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            actions: [
              IconButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme();
                },
                icon: Icon(
                  Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
              ),
            ],
          ),
          body:
          games.isEmpty
              ? Center(child: Text('Nenhum jogo salvo ainda.'))
              : Center(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate((context,
                      index,) {
                    final game = games[index];
                    return GameCard(game: game);
                  }, childCount: games.length),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                    MediaQuery
                        .of(context)
                        .orientation ==
                        Orientation.landscape
                        ? 4
                        : 2,
                    childAspectRatio:
                    MediaQuery
                        .of(context)
                        .orientation ==
                        Orientation.portrait
                        ? 4 / 5
                        : 7 / 8,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchScreen()),
              ).then((result) {
                if (result == true) {
                  if (context.mounted) {
                    Provider.of<GameProvider>(
                      context,
                      listen: false,
                    ).loadGames();
                  }
                }
              });
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
