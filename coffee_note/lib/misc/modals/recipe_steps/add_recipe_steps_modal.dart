import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/ingredients/ingredient_units.dart';
import 'package:coffee_note/models/steps/recipe_step.dart';
import 'package:coffee_note/providers/recipe_add_form_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddRecipeStepsModal extends ConsumerStatefulWidget {
  final WidgetRef ref;

  const AddRecipeStepsModal({
    super.key,
    required this.ref,
  });

  @override
  _AddRecipeStepsModalState createState() => _AddRecipeStepsModalState();
}

class _AddRecipeStepsModalState extends ConsumerState<AddRecipeStepsModal> {
  late final TextEditingController stepDescriptionController;
  late int id;

  @override
  void initState() {
    super.initState();
    id = widget.ref.read(recipeIngredientNotifierProvider).steps.length + 1;
    stepDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    stepDescriptionController.dispose();
    super.dispose();
  }

  void _addStep (BuildContext context) {
    final step = stepDescriptionController.text.trim();
    if (step.isNotEmpty) {    
      widget.ref
          .read(recipeIngredientNotifierProvider.notifier)
          .addStep(RecipeStep(id: id, description: step));

      setState(() {
        id = widget.ref.read(recipeIngredientNotifierProvider).steps.length + 1;
        stepDescriptionController.text = "";
      });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill the fields correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Step"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: stepDescriptionController,
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
          onPressed: () => _addStep(context),
          child: const Text("Add Step"),
        ),
      ],
    );
  }
}
