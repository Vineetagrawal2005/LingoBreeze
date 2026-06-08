import 'package:flutter/material.dart';
import 'package:lingobrezza/core/constants.dart';
import 'package:provider/provider.dart';
import '../providers/word_provider.dart';
import '../widgets/word_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/add_word_sheet.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<WordProvider>().fetchWords();
    });
  }

  void _openAddWordSheet() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const AddWordSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Vocabulary", style: AppTextStyles.wordHeader),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddWordSheet,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.textWhite),
      ),
      body: SafeArea(
        child: Consumer<WordProvider>(
          builder: (context, provider, _) {
            final words = provider.words;
            if (provider.isLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppColors.primary),
                    SizedBox(height: 16),
                    Text(
                      'Loading your words...',
                      style: TextStyle(color: AppColors.textBlack),
                    ),
                  ],
                ),
              );
            }
            
            final errorMessage = provider.error;
            if (errorMessage != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        size: 64,
                        color: AppColors.errorColor,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Something went wrong',
                        style: AppTextStyles.wordTitle,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.textBlack),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => provider.fetchWords(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            
            if (words.isEmpty) {
              return EmptyState(onAddWord: _openAddWordSheet);
            }
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () => provider.fetchWords(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: words.length,
                itemBuilder: (context, index) {
                  return WordCard(word: words[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
