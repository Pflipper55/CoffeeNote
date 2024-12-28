import 'package:coffee_note/models/ingredient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeIngredientProvider extends Notifier<Set<Ingredient>> {
  @override
  Set<Ingredient> build() {
    return {};
  }
}

final recipeIngredientNotifierProvider = NotifierProvider<RecipeIngredientProvider, Set<Ingredient>>(() {
  return RecipeIngredientProvider();
});