import 'package:coffee_note/models/ingredients/ingredient_units.dart';

class Ingredient {
  final int id;
  final String name;
  final double amount;
  final IngredientUnits unit;

  const Ingredient({required this.id, required this.name, required this.amount, required this.unit});
}