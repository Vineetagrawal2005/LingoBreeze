import 'package:flutter/material.dart';
import 'package:lingobrezza/data/Repositories/word_repository.dart';
import 'package:lingobrezza/data/models/word_model.dart';

class WordProvider with ChangeNotifier {
  final _repository = WordRepository();
  List<WordModel> _words = [];
  bool _isLoading = false;
  String? _error;

  List<WordModel> get words => _words;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Future<void> fetchWords() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _words = await _repository.getWords();
    } catch (e) {
      _error = 'Could not load words.Check your connection.';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addWord(String word, String meaning, String translation) async {
    final newword = WordModel(
      id: '',
      word: word,
      meaning: meaning,
      translation: translation,
    );
    await _repository.addWords(newword);
    await fetchWords();
  }
}
