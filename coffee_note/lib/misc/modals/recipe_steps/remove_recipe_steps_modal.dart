import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/ingredients/ingredient_units.dart';
import 'package:coffee_note/models/steps/recipe_step.dart';
import 'package:coffee_note/providers/recipe_add_form_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoveRecipeStepModal extends ConsumerStatefulWidget {
  final WidgetRef ref;

  const RemoveRecipeStepModal({
    super.key,
    required this.ref,
  });

  @override
  _RemoveRecipeStepModalState createState() => _RemoveRecipeStepModalState();
}

class _RemoveRecipeStepModalState extends ConsumerState<RemoveRecipeStepModal> {
  List<RecipeStep> steps = [];
  Map<int,bool> selectedSteps = {};
  @override
  void initState() {
    super.initState();
    steps = widget.ref.read(recipeIngredientNotifierProvider.notifier).getSteps();
    selectedSteps = {
      for (var step in steps) step.id: false,
    };
  }

 void removeSelectedSteps() {
    final stepsToRemove = steps
        .where((step) => selectedSteps[step.id]!)
        .toList();

    for (var step in stepsToRemove) 
    {
      widget.ref
          .read(recipeIngredientNotifierProvider.notifier)
          .removeStep(step);
    }
    Navigator.pop(context);
 }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Remove Steps"),
      content: ListView.builder(
        itemCount: steps.length,
        itemBuilder: (context, index) {
          final item = steps[index];
          return CheckboxListTile(
            title: Text(item.description),
            value: selectedSteps[item.id],
            onChanged: (value) {
              setState(() {
                selectedSteps[item.id] = value ?? false;
              });
            },
          );
        }
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Close modal
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: removeSelectedSteps,
          child: const Text("Remove Selected"),
        ),
      ],
    );
  }


}
