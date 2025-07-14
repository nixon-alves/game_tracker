import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_tracker/screens/search_screen.dart';

void main() {
  testWidgets('SearchScreen shows initial layout correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SearchScreen())
    );

    expect(find.text("Procure um jogo!"), findsOneWidget);
    expect(find.text("Digite o nome do jogo"), findsOneWidget);
    expect(find.text("Nenhum resultado"), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
