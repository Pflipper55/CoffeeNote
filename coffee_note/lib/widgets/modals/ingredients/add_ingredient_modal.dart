import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/ingredients/ingredient_units.dart';
import 'package:coffee_note/providers/recipe_add_form_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddIngredientModal extends ConsumerStatefulWidget {
  final WidgetRef ref;

  const AddIngredientModal({
    super.key,
    required this.ref,
  });

  @override
  _AddIngredientModalState createState() => _AddIngredientModalState();
}

class _AddIngredientModalState extends ConsumerState<AddIngredientModal> {
  late final TextEditingController nameController;
  late final TextEditingController amountController;
  late int id;
  IngredientUnits selectedUnit = IngredientUnits.gram;

  @override
  void initState() {
    super.initState();
    id = widget.ref.read(recipeIngredientNotifierProvider.notifier).getNextIngredientId();
    nameController = TextEditingController();
    amountController = TextEditingController();
    selectedUnit = IngredientUnits.gram;
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _addIngredient(BuildContext context) {
    final name = nameController.text.trim();
    final amount = double.tryParse(amountController.text.trim()) ?? 0;

    if (name.isNotEmpty && amount > 0) {
      final newIngredient = Ingredient(
        id: id,
        name: name,
        amount: amount,
        unit: selectedUnit,
      );

      widget.ref
          .read(recipeIngredientNotifierProvider.notifier)
          .addIngredient(newIngredient);

      setState(() {
        id = widget.ref.read(recipeIngredientNotifierProvider.notifier).getNextIngredientId();
        nameController.text = "";
        amountController.text = "";
        selectedUnit = IngredientUnits.gram;
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
      title: const Text("Add Ingredient"),
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
          onPressed: () => _addIngredient(context),
          child: const Text("Add Ingredient"),
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
