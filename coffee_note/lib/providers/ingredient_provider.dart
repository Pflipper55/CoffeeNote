import 'package:coffee_note/models/ingredient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// ToDo: Remove
List<Ingredient> allIngridients = [
  Ingredient(id: 0, name: "Lorem Ingridient", amount: 2, unit: "g"),
  Ingredient(id: 1, name: "Lorem Ingridient 1", amount: 3, unit: "g"),
  Ingredient(id: 2, name: "Lorem Ingridient 2", amount: 4, unit: "g"),
  Ingredient(id: 3, name: "Lorem Ingridient 3", amount: 5, unit: "g"),
  Ingredient(id: 4, name: "Lorem Ingridient 4", amount: 6, unit: "g"),
  Ingredient(id: 5, name: "Lorem Ingridient 5", amount: 7, unit: "g"),
];

@riverpod
final allIngredientProvider = Provider((ref) => allIngridients);
