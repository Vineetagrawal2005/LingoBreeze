import 'package:flutter/material.dart';
import 'package:lingobrezza/presentation/providers/word_provider.dart';
import 'package:lingobrezza/presentation/screens/vocabulary_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create: (_)=>WordProvider(),
    child: const MyApp(),),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LingoBreeze',
      debugShowCheckedModeBanner: false,
      home: VocabularyScreen(),
    );
  }
}
