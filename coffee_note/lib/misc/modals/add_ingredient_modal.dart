import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/ingredients/ingredient_units.dart';
import 'package:coffee_note/providers/recipe_add_form_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddIngredientModal extends StatefulWidget {
  final WidgetRef ref;
  const AddIngredientModal({Key? key, required WidgetRef this.ref}) : super(key: key);

  @override
  _AddIngredientModalState createState() => _AddIngredientModalState();
}

class _AddIngredientModalState extends State<AddIngredientModal> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  IngredientUnits selectedUnit = IngredientUnits.gram; // Default unit

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Ingredient"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Ingredient Name"),
            ),
            SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                DropdownButton<IngredientUnits>(
                  value: selectedUnit,
                  onChanged: (IngredientUnits? newUnit) {
                    setState(() {
                      selectedUnit = newUnit!;
                    });
                  },
                  items: IngredientUnits.values.map((unit) {
                    return DropdownMenuItem<IngredientUnits>(
                      value: unit,
                      child: Text(unit.displayName),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close modal
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final name = nameController.text.trim();
            final amount = double.tryParse(amountController.text.trim()) ?? 0;
            if (name.isNotEmpty && amount > 0) {
              final ingredient = Ingredient(
                name: name,
                amount: amount,
                unit: selectedUnit,
              );
              widget.ref.read(recipeIngredientNotifierProvider.notifier).addIngredient(ingredient);
              Navigator.pop(context); // Close modal
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill the fields correctly')),
              );
            }
          },
          child: Text("Add Ingredient"),
        ),
      ],
    );
  }
}