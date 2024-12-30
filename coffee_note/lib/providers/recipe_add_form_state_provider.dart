import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/recipes/recipe_add_form_state.dart';
import 'package:coffee_note/models/steps/recipe_step.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeAddFormStateProvider extends Notifier<RecipeAddFormState> {
  @override
  RecipeAddFormState build() => RecipeAddFormState();

  /// Fügt ein neues Ingredient hinzu, wenn es noch nicht existiert.
  void addIngredient(Ingredient ingredient) {
    if (!_ingredientExists(ingredient)) {
      state = state.copyWith(
        ingredients: [...state.ingredients, ingredient],
      );
    }
  }

  /// Entfernt ein Ingredient basierend auf seiner ID.
  void removeIngredient(Ingredient ingredient) {
    state = state.copyWith(
      ingredients: state.ingredients.where((i) => i.id != ingredient.id).toList(),
    );
  }

  /// Aktualisiert ein bestehendes Ingredient basierend auf seiner ID.
  void updateIngredient(Ingredient updatedIngredient) {
    state = state.copyWith(
      ingredients: state.ingredients.map((ingredient) {
        return ingredient.id == updatedIngredient.id ? updatedIngredient : ingredient;
      }).toList(),
    );
  }

  void addStep(RecipeStep step) {
    if(!state.steps.contains(step)){
      state = state.copyWith(
        steps: [...state.steps, step],
      );
    }
  }

  void removeStep(RecipeStep step) {
    if(state.steps.contains(step)){
      state = state.copyWith(
        steps: state.steps.where((i) => i.id != step.id).toList(),
      );
    }
  }

  void updateStep(RecipeStep step) {
    state = state.copyWith(
      steps: state.steps.map((s) {
        return s.id == step.id ? step : s;
      }).toList(),
    );
  }

  /// Aktualisiert den Titel, falls er sich geändert hat.
  void updateTitle(String title) {
    if (state.title != title) {
      state = state.copyWith(title: title);
    }
  }

  /// Aktualisiert die Beschreibung, falls sie sich geändert hat.
  void updateDescription(String description) {
    if (state.description != description) {
      state = state.copyWith(description: description);
    }
  }

  /// Gibt die nächste freie Ingredient-ID zurück.
  int getNextIngredientId() {
    return state.ingredients.isNotEmpty
        ? state.ingredients.map((i) => i.id).reduce((a, b) => a > b ? a : b) + 1
        : 1;
  }

    int getNextStepId() {
    return state.steps.isNotEmpty
        ? state.steps.map((i) => i.id).reduce((a, b) => a > b ? a : b) + 1
        : 1;
  }

  List<Ingredient> getIngredients() => state.ingredients;

  List<RecipeStep> getSteps() => state.steps;

  /// Setzt den Zustand auf die ursprünglichen Werte zurück.
  void resetState() {
    state = build();
  }

  /// Überprüft, ob ein Ingredient bereits existiert.
  bool _ingredientExists(Ingredient ingredient) {
    return state.ingredients.any((i) => i.id == ingredient.id);
  }
}

/// Provider für den RecipeAddFormState.
final recipeIngredientNotifierProvider =
    NotifierProvider<RecipeAddFormStateProvider, RecipeAddFormState>(
  () => RecipeAddFormStateProvider(),
);
