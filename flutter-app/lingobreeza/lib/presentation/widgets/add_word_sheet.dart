import 'package:flutter/material.dart';
import 'package:lingobrezza/core/constants.dart';
import 'package:provider/provider.dart';
import '../providers/word_provider.dart';

class AddWordSheet extends StatefulWidget {
  const AddWordSheet({super.key});

  @override
  State<AddWordSheet> createState() => _AddWordSheetState();
}

class _AddWordSheetState extends State<AddWordSheet> {
  final _formKey = GlobalKey<FormState>();
  final _wordController = TextEditingController();
  final _meaningController = TextEditingController();
  final _translationController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _wordController.dispose();
    _meaningController.dispose();
    _translationController.dispose();
    super.dispose();
  }

  Future<void> _saveWord() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      await context.read<WordProvider>().addWord(
        _wordController.text.trim(),
        _meaningController.text.trim(),
        _translationController.text.trim(),
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save word. Try again.'),
            backgroundColor: AppColors.errorColor,
          ),
        );
      }
    }

    if (mounted) setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ───────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Add New Word', style: AppTextStyles.wordTitle),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: Colors.grey,
                  ),
                ],
              ),

              Text(
                'Fill all fields to save a new word',
                style: AppTextStyles.wordTitle,
              ),

              const SizedBox(height: 20),

              // ── Word Field ───────────────────
              _buildField(
                controller: _wordController,
                label: 'Word',
                hint: 'e.g. Apple',
                icon: Icons.spellcheck,
              ),

              const SizedBox(height: 14),

              // ── Meaning Field ────────────────
              _buildField(
                controller: _meaningController,
                label: 'Meaning',
                hint: 'e.g. A fruit',
                icon: Icons.book_outlined,
              ),

              const SizedBox(height: 14),

              // ── Translation Field ────────────
              _buildField(
                controller: _translationController,
                label: 'Translation',
                hint: 'e.g. Manzana',
                icon: Icons.translate,
              ),

              const SizedBox(height: 24),

              // ── Save Button ─────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveWord,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Save Word',
                          style: AppTextStyles.buttonText,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: AppColors.textWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }
}
