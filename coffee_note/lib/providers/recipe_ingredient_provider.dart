import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/recipes/recipe_add_form_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeIngredientProvider extends Notifier<RecipeAddFormState> {
  @override
  RecipeAddFormState build() {
    return RecipeAddFormState();
  }

  void addIngredient(Ingredient ingredient){
    final updatedIngredients = [...state.ingredients, ingredient];
    state = state.copyWith(ingredients: updatedIngredients);
  }
}

final recipeIngredientNotifierProvider = NotifierProvider<RecipeIngredientProvider, RecipeAddFormState>(() {
  return RecipeIngredientProvider();
});