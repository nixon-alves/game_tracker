import 'package:flutter/material.dart';
import 'package:game_tracker/models/game.dart';
import 'package:game_tracker/models/game_provider.dart';
import 'package:provider/provider.dart';

class GameDetailScreen extends StatefulWidget {
  final Game game;

  const GameDetailScreen({super.key, required this.game});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  String status = 'Não iniciado';
  double rating = 0;
  DateTime? selectedDate;

  void _saveGame() async {
    final game = Game(
      widget.game.title,
      widget.game.image,
      rating.toStringAsFixed(1),
      status,
      selectedDate != null
          ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
          : '',
    );

    await Provider.of<GameProvider>(
      context,
      listen: false,
    ).addOrUpdateGames(game);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          ElevatedButton(
            onPressed: () {
              _saveGame();
            },
            child: Text('Salvar'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLandscape ? _buildLandscape() : _buildPortrait(),
      ),
    );
  }

  Widget _buildPortrait() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Image.network(widget.game.image, height: 150, fit: BoxFit.cover),
          const SizedBox(height: 20),
          Text(
            widget.game.title,
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildFormFields(),
        ],
      ),
    );
  }

  Widget _buildLandscape() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(widget.game.image, height: 150, fit: BoxFit.cover),
              const SizedBox(height: 20),
              Text(widget.game.title, style: TextStyle(fontSize: 25)),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Expanded(child: _buildFormFields()),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField(
          value: status,
          decoration: const InputDecoration(labelText: 'Status'),
          isDense: false,
          items:
              [
                'Não iniciado',
                'Jogando',
                'Finalizado',
              ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
          onChanged: (value) => setState(() => status = value!),
        ),
        if (status == 'Finalizado') ...[
          SizedBox(height: 16),
          Text('Nota: ${rating.toStringAsFixed(1)}'),
          Slider(
            value: rating,
            min: 0,
            max: 5,
            divisions: 10,
            label: rating.toStringAsFixed(1),
            onChanged: (value) => setState(() => rating = value),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                selectedDate == null
                    ? 'Nenhuma data selecionada'
                    : 'Data: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) setState(() => selectedDate = date);
                },
                child: const Text('Selecionar data'),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
