import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:abc/widgets/word_display.dart';
import 'package:abc/models/word.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('WordDisplay renders correctly and adapts to new word', (WidgetTester tester) async {
    // Mock data for testing
    final mockWords = ['apple', 'banana', 'cherry', 'date'];
    final wordModel = WordModel(initialWords: mockWords);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => wordModel,
        child: const MaterialApp(
          home: Scaffold(
            body: WordDisplay(),
          ),
        ),
      ),
    );

    // Check if the initial word is displayed correctly
    expect(find.text(wordModel.word), findsOneWidget);

    // Update the word in the model
    wordModel.word = 'banana';
    await tester.pump();

    // Ensure the new word is displayed
    expect(find.text('banana'), findsOneWidget);
  });
}
