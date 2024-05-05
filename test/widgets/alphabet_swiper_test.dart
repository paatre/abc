import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:abc/widgets/alphabet_swiper.dart';
import 'package:abc/models/word.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('AlphabetSwiper renders correctly and changes letter', (WidgetTester tester) async {
    // Mock data for testing
    final mockWords = ['apple', 'banana', 'cherry', 'date'];
    final wordModel = WordModel(initialWords: mockWords);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => wordModel,
        child: const MaterialApp(
          home: Scaffold(
            body: AlphabetSwiper(),
          ),
        ),
      ),
    );

    // Ensure the first letter is 'A'
    expect(find.text('A'), findsOneWidget);

    // Swipe to the next letter
    await tester.fling(find.text('A'), const Offset(-300, 0), 500);
    await tester.pumpAndSettle();

    // Check if the model's letter is 'B'
    expect(wordModel.letter, 'B');
  });
}
