import 'package:flutter/material.dart';
import 'package:lingobrezza/core/constants.dart';
import 'package:lingobrezza/data/models/word_model.dart';

class WordCard extends StatelessWidget {
  final WordModel word;
  const WordCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      color: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      elevation: 2,

      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(word.word, style: AppTextStyles.bodyDefinition),
            SizedBox(height: 10),
            Divider(height: 1, color: AppColors.textWhite),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.book_outlined,
                  size: 16,
                  color: AppColors.textWhite,
                ),
                const SizedBox(width: 8),
                Text('Meaning: ', style: AppTextStyles.wordTitle),
                Expanded(
                  child: Text(
                    word.meaning,
                    style: AppTextStyles.bodyDefinition,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.translate,
                  size: 16,
                  color: AppColors.textWhite,
                ),
                const SizedBox(width: 8),
                Text('Translation: ', style: AppTextStyles.wordTitle),
                Expanded(
                  child: Text(
                    word.translation,
                    style: AppTextStyles.bodyDefinition,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
