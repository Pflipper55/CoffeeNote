import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/ingredients/ingredient_units.dart';
import 'package:coffee_note/providers/recipe_add_form_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditIngredientModal extends ConsumerStatefulWidget {
  final WidgetRef ref;
  final Ingredient ingredient;

  const EditIngredientModal({
    super.key,
    required this.ingredient,
    required this.ref,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditIngredientState();
}

class _EditIngredientState extends ConsumerState<EditIngredientModal> {
  late final TextEditingController nameController;
  late final TextEditingController amountController;
  late IngredientUnits selectedUnit;
  late int id;

  @override
  void initState() {
    super.initState();
    final ingredient = widget.ingredient;
    id = ingredient.id;
    selectedUnit = ingredient.unit;
    nameController = TextEditingController(text: ingredient.name);
    amountController = TextEditingController(text: ingredient.amount.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _updateIngredient(BuildContext context) {
    final name = nameController.text.trim();
    final amount = double.tryParse(amountController.text.trim()) ?? 0;

    if (name.isNotEmpty && amount > 0) {
      final updatedIngredient = Ingredient(
        id: id,
        name: name,
        amount: amount,
        unit: selectedUnit,
      );

      widget.ref
          .read(recipeIngredientNotifierProvider.notifier)
          .updateIngredient(updatedIngredient);

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
      title: const Text("Edit Ingredient"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField(
              controller: nameController,
              label: "Ingredient Name",
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: amountController,
              label: "Amount",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildDropdown(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Close modal
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => _updateIngredient(context),
          child: const Text("Update Ingredient"),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _buildDropdown() {
    return Row(
      children: [
        DropdownButton<IngredientUnits>(
          value: selectedUnit,
          onChanged: (newUnit) {
            if (newUnit != null) {
              setState(() => selectedUnit = newUnit);
            }
          },
          items: IngredientUnits.values.map((unit) {
            return DropdownMenuItem<IngredientUnits>(
              value: unit,
              child: Text(unit.displayName),
            );
          }).toList(),
        ),
      ],
    );
  }
}
