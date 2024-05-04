import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class WordModel with ChangeNotifier {
  List<String> _words = [];
  String _letter = 'A';
  String _word = '';

  WordModel() {
    loadWords();
  }

  List<String> get words => _words;
  String get letter => _letter;
  String get word => _word;

  set letter(String newLetter) {
    _letter = newLetter;
    notifyListeners();
  }

  set word(String newWord) {
    _word = newWord;
    notifyListeners();
  }

  Future<void> loadWords() async {
    try {
      final data = await rootBundle.loadString('assets/data/words');
      _words = data.split('\n').where((word) => word.isNotEmpty).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load words: $e');
    }
  }

  final alphabet = List.unmodifiable(
    List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index))
  );

  void shuffleWords() {
    _words.shuffle();
    if (_words.isNotEmpty) _word = _words.first;
    notifyListeners();
  }
}
