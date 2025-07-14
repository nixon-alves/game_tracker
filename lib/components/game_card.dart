import 'package:flutter/material.dart';
import 'package:game_tracker/common/options_modal.dart';
import 'package:game_tracker/models/game.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showGameOptionsModal(context, game);
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.hardEdge,
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image(
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
                image: NetworkImage(game.image),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
                  child: Column(
                    children: [
                      Text(
                        game.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(game.status),
                      if (game.status == 'Finalizado') ...[
                        if (game.rating != null) Text(game.rating!),
                        if (game.date != null && game.date!.isNotEmpty)
                          Text(game.date!),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
