import 'package:flutter/material.dart';
import 'package:game_tracker/common/confirmation_dialog.dart';
import 'package:game_tracker/models/game.dart';
import 'package:game_tracker/models/game_provider.dart';
import 'package:game_tracker/screens/game_detail_screen.dart';
import 'package:provider/provider.dart';

void showGameOptionsModal(BuildContext context, Game game) {
  showModalBottomSheet(
    context: context,
    builder:
        (_) => Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Editar"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GameDetailScreen(game: game),
                  ),
                ).then((result) {
                  if (result == true && context.mounted) {
                    Provider.of<GameProvider>(
                      context,
                      listen: false,
                    ).loadGames();
                  }
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Excluir"),
              onTap: () async {
                Navigator.pop(context);
                final confirmed = await showConfirmationDialog(
                  context,
                  gameTitle: game.title,
                );
                if (confirmed == true && context.mounted) {
                  Provider.of<GameProvider>(
                    context,
                    listen: false,
                  ).removeGame(game.title);
                }
              },
            ),
          ],
        ),
  );
}
