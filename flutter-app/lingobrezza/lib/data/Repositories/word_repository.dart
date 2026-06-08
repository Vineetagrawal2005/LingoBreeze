import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:lingobrezza/data/models/word_model.dart';
import 'package:lingobrezza/core/constants.dart';

class WordRepository {
  final _firestore = FirebaseFirestore.instance;
  Future<List<WordModel>> getWords() async {
    final response = await http.get(Uri.parse('${getApiUrl()}/words'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => WordModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load words');
    }
  }

  Future<void> addWords(WordModel word) async {
    await _firestore.collection('words').add(word.toMap());
  }
}
