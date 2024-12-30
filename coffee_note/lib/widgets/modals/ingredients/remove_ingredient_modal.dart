import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/ingredients/ingredient_units.dart';
import 'package:coffee_note/providers/recipe_add_form_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoveIngredientModal extends ConsumerStatefulWidget {
  final WidgetRef ref;

  const RemoveIngredientModal({
    super.key,
    required this.ref,
  });

  @override
  _RemoveIngredientModalState createState() => _RemoveIngredientModalState();
}

class _RemoveIngredientModalState extends ConsumerState<RemoveIngredientModal> {
  List<Ingredient> ingredients = [];
  Map<int,bool> selectedIngredients = {};
  @override
  void initState() {
    super.initState();
    ingredients = widget.ref.watch(recipeIngredientNotifierProvider.notifier).getIngredients();
    selectedIngredients = {
      for (var ingredient in ingredients) ingredient.id: false,
    };
  }

 void removeSelectedIngredients() {
    final ingredientsToRemove = ingredients
        .where((ingredient) => selectedIngredients[ingredient.id]!)
        .toList();

    for (var ingredient in ingredientsToRemove) 
    {
      widget.ref
          .read(recipeIngredientNotifierProvider.notifier)
          .removeIngredient(ingredient);
    }
    Navigator.pop(context);
 }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Remove Ingredients"),
      content: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final item = ingredients[index];
          return CheckboxListTile(
            title: Text(item.name),
            subtitle: Text("${item.amount} ${item.unit.displayName}"),
            value: selectedIngredients[item.id],
            onChanged: (value) {
              setState(() {
                selectedIngredients[item.id] = value ?? false;
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
          onPressed: removeSelectedIngredients,
          child: const Text("Remove Selected"),
        ),
      ],
    );
  }


}
