import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class WordModel with ChangeNotifier {
  List<String> _allWords = [];
  List<String> _filteredWords = [];
  String _letter = 'A';
  String _word = '';

  WordModel() {
    loadWords();
  }

  List<String> get words => _filteredWords;
  String get letter => _letter;
  String get word => _word;

  set letter(String newLetter) {
    _letter = newLetter;
    filterWordsByLetter();
    notifyListeners();
  }

  set word(String newWord) {
    _word = newWord;
    notifyListeners();
  }

  Future<void> loadWords() async {
    try {
      final data = await rootBundle.loadString('assets/data/words');
      _allWords = data.split('\n').where((word) => word.isNotEmpty).toList();
      filterWordsByLetter();
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load words: $e');
    }
  }

  void filterWordsByLetter() {
    _filteredWords = _allWords.where((word) => word.toLowerCase().startsWith(_letter.toLowerCase())).toList();
    _word = _filteredWords.isNotEmpty ? _filteredWords.first : '';
  }

  void shuffleWords() {
    if (_filteredWords.length > 1) {
      final initialFirstWord = _filteredWords.first;
      do {
        _filteredWords.shuffle();
      } while (_filteredWords.first == initialFirstWord);
    }
    _word = _filteredWords.isNotEmpty ? _filteredWords.first : '';
    notifyListeners();
  }
}
