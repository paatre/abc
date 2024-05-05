import 'package:flutter_test/flutter_test.dart';
import 'package:abc/models/word.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WordModel Tests', () {
    late WordModel model;
    final mockWords = [
      'apple', 'apricot', 'avocado',
      'banana', 'blueberry', 'blackberry',
      'cherry',
      'date',
      'elderberry',
      'fig',
      'grape'
    ];

    setUp(() {
      model = WordModel(initialWords: mockWords);
    });

    test('Initial letter is A', () {
      expect(model.letter, 'A');
    });

    test('Filtering words by letter', () {
      model.letter = 'b';
      expect(model.letter, 'b');
      expect(model.words.every((word) => word.startsWith('b')), isTrue);
    });

    test('Shuffling words when multiple words exist', () {
      model.letter = 'a';
      final initialFirstWord = model.words.first;
      model.shuffleWords();
      expect(model.words.first, isNot(initialFirstWord));
    });

    test('Shuffling words when only one word exists', () {
      model.letter = 'g';
      final initialFirstWord = model.words.first;
      model.shuffleWords();
      expect(model.words.first, initialFirstWord);
    });

    test('Setting new word', () {
      const word = 'banana';
      model.word = word;
      expect(model.word, word);
    });
  });
}
