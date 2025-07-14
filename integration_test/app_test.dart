import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game_tracker/main.dart' as app;

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration Test', (tester) async{
    app.main();
    await tester.pumpAndSettle();

    // Tela inicial
    expect(find.text("Lista de Jogos"), findsOneWidget);
    expect(find.text("Nenhum jogo salvo ainda."), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // Navegar para a tela de busca
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Tela de busca
    expect(find.text("Procure um jogo!"), findsOneWidget);
    expect(find.text("Digite o nome do jogo"), findsOneWidget);
    expect(find.text("Nenhum resultado"), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Buscar jogo
    await tester.enterText(find.byType(TextField), '3');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Abrir detalhes do jogo
    await tester.tap(find.text("The Witcher 3: Wild Hunt"));
    await tester.pumpAndSettle();
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text("The Witcher 3: Wild Hunt"), findsOneWidget);
    expect(find.text("Status"), findsOneWidget);
    expect(find.text("Não iniciado"), findsOneWidget);

    // Alterar status para "Finalizado"
    await tester.tap(find.text('Não iniciado'));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Finalizado"));
    await tester.pumpAndSettle();


    // Verificar campos extras para status "Finalizado"
    expect(find.text("Nota: 0.0"), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
    expect(find.text("Nenhuma data selecionada"), findsOneWidget);
    expect(find.text("Selecionar data"), findsOneWidget);

    // Definir nota e data
    await tester.drag(find.byType(Slider), Offset(150, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Selecionar data"));
    await tester.pumpAndSettle();
    expect(find.text("Select date"), findsOneWidget);
    expect(find.text("Cancel"), findsOneWidget);
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    // Salvar jogo
    await tester.tap(find.text("Salvar"));
    await tester.pumpAndSettle();

    // Verifica jogo salvo na lista
    expect(find.text("Lista de Jogos"), findsOneWidget);
    expect(find.text("The Witcher 3: Wild Hunt"), findsOneWidget);
    expect(find.text('5.0'), findsOneWidget);
    expect(find.textContaining("/"), findsOneWidget);
    expect(find.text("Nenhum jogo salvo ainda."), findsNWidgets(0));

    // Alternar para modo escuro
    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pumpAndSettle();
    final context = tester.element(find.byType(Scaffold));
    expect(Theme.of(context).brightness, Brightness.dark);

    // Voltar para modo claro
    await tester.tap(find.byIcon(Icons.light_mode));
    await tester.pumpAndSettle();

    // Abrir menu de edição
    await tester.tap(find.text("Finalizado"));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.edit), findsOneWidget);
    expect(find.text("Editar"), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);
    expect(find.text("Excluir"), findsOneWidget);

    // Editar status para jogando
    await tester.tap(find.text("Editar"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Não iniciado'));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Jogando"));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Salvar"));
    await tester.pumpAndSettle();

    // Excluir o jogo
    await tester.tap(find.text("Jogando"));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Excluir"));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Atenção!"), findsOneWidget);
    await tester.tap(find.text("Confirmar"));
    await tester.pumpAndSettle();

    // Verifica se a lista voltou a ficar vazia
    expect(find.text("Nenhum jogo salvo ainda."), findsOneWidget);
  });
}