import 'package:coffee_note/models/steps/recipe_step.dart';
import 'package:coffee_note/providers/recipe_add_form_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditRecipeStepModal extends ConsumerStatefulWidget {
  final WidgetRef ref;
  final RecipeStep step;

  const EditRecipeStepModal({
    super.key,
    required this.step,
    required this.ref,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditRecipeStepState();
}

class _EditRecipeStepState extends ConsumerState<EditRecipeStepModal> {
  late final TextEditingController descriptionController;
  late int id;

  @override
  void initState() {
    super.initState();
    final step = widget.step;
    id = step.id;
    descriptionController = TextEditingController(text: step.description);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void _updateStep(BuildContext context) {
    final description = descriptionController.text.trim();

    if (description.isNotEmpty) {
      final updatedStep = RecipeStep(
        id: id,
        description: description,
      );

      widget.ref
          .read(recipeIngredientNotifierProvider.notifier)
          .updateStep(updatedStep);

      Navigator.pop(context); // Close modal
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill the fields correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Step"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              maxLines: 5,
              maxLength: 120,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Close modal
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => _updateStep(context),
          child: const Text("Update Ingredient"),
        ),
      ],
    );
  }
}
