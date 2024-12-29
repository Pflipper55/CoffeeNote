import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/ingredients/ingredient_units.dart';
import 'package:coffee_note/models/recipes/recipe_add_form_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeAddFormStateProvider extends Notifier<RecipeAddFormState> {
  @override
  RecipeAddFormState build() {
    return RecipeAddFormState();
  }

  // ToDo Add Database

  void addIngredient(Ingredient ingredient){
    if(!state.ingredients.contains(ingredient)) {
      final updatedIngredients = [...state.ingredients, ingredient];
      state = state.copyWith(ingredients: updatedIngredients);
    }
  }

  void removeIngredient(Ingredient ingredient){
    if(state.ingredients.contains(ingredient)) {
      state.ingredients.removeWhere((i) => i.id == ingredient.id);
    }
  }

  void updateIngredient(Ingredient updatedIngredient) {
    state = state.copyWith(
      ingredients: [
        for (final ingredient in state.ingredients)
          if (ingredient.id == updatedIngredient.id)
            updatedIngredient
          else
            ingredient,
      ],
    );
  }

  void updateTitle(String title){
    if(state.title.compareTo(title) != 0){
      state.title = title;
    }
  }

  void updateDescription(String description){
    if(state.description.compareTo(description) != 0){
      state.description = description;
    }
  }

  int getNextIngredientId() {
    // ToDo replace
    return state.ingredients.length + 1;
  }

  void resetState() => build();
}

final recipeIngredientNotifierProvider = NotifierProvider<RecipeAddFormStateProvider, RecipeAddFormState>(() {
  return RecipeAddFormStateProvider();
});