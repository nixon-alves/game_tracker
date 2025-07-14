import 'package:flutter/material.dart';
import 'package:game_tracker/data/fake_api.dart';
import 'package:game_tracker/models/game.dart';
import 'package:game_tracker/models/game_provider.dart';
import 'package:game_tracker/models/game_search_result.dart';
import 'package:game_tracker/screens/game_detail_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';
  List<GameSearchResult> _results = [];

  void _search() async {
    final results = await fakeSearchGames(_query);
    setState(() {
      _results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Procure um jogo!"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Digite o nome do jogo',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
              onChanged: (value) => _query = value,
              onSubmitted: (_) => _search(),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child:
                _results.isEmpty
                    ? const Center(child: Text("Nenhum resultado"))
                    : MediaQuery.of(context).orientation == Orientation.portrait
                    ? _PortraitList(results: _results)
                    : _LandscapeGrid(results: _results),
          ),
        ],
      ),
    );
  }
}

class _PortraitList extends StatelessWidget {
  final List<GameSearchResult> results;

  const _PortraitList({required this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final game = results[index];
        return ListTile(
          leading: Image.network(
            game.image,
            width: 130,
            height: 80,
            fit: BoxFit.cover,
          ),
          title: Text(game.title),
          subtitle: Text('${game.company} • ${game.year}'),
          onTap: () {
            _goToDetail(context, game);
          },
        );
      },
    );
  }
}

class _LandscapeGrid extends StatelessWidget {
  final List<GameSearchResult> results;

  const _LandscapeGrid({required this.results});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 6,
      ),
      itemBuilder: (context, index) {
        final game = results[index];
        return ListTile(
          leading: Image.network(
            game.image,
            width: 130,
            height: 80,
            fit: BoxFit.cover,
          ),
          title: Text(game.title),
          subtitle: Text('${game.company} • ${game.year}'),
          onTap: () {
            _goToDetail(context, game);
          },
        );
      },
    );
  }
}

void _goToDetail(BuildContext context, GameSearchResult game) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder:
          (_) => GameDetailScreen(
            game: Game(game.title, game.image, '', 'Não iniciado', ''),
          ),
    ),
  );
  if (result == true && context.mounted) {
    Provider.of<GameProvider>(context, listen: false).loadGames();
    Navigator.pop(context);
  }
}
