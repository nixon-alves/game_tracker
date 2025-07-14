import 'package:flutter/material.dart';
import 'package:game_tracker/data/game_dao.dart';

Future<dynamic> showConfirmationDialog(
  BuildContext context, {
  required String gameTitle,
  String title = 'Atenção!',
  String content = "Você realmente deseja excluir esse jogo?",
  String affirmationOption = "Confirmar",
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(affirmationOption),
          ),
        ],
      );
    },
  );
}
