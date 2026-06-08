import 'package:flutter/material.dart';
import 'package:lingobrezza/core/constants.dart';

class EmptyState extends StatelessWidget {
  final VoidCallback onAddWord;
  const EmptyState({
    super.key,
    required this.onAddWord,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                size: 64,
                color: AppColors.textWhite,
              ),
            ),

            const SizedBox(height: 24),

            // Main message
            const Text(
              "You haven't saved any words yet",
              textAlign: TextAlign.center,
              style: AppTextStyles.wordTitle,
            ),

            const SizedBox(height: 8),

            // Sub message
            Text(
              'Start building your vocabulary!',
              textAlign: TextAlign.center,
              style: AppTextStyles.wordTitle,
            ),

            const SizedBox(height: 32),

            // Button
            ElevatedButton.icon(
              onPressed: onAddWord,
              icon: const Icon(Icons.add),
              label: const Text(
                'Add Your First Word',
                style: AppTextStyles.buttonText,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textWhite,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
