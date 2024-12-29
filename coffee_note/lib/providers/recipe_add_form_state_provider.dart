import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/recipes/recipe_add_form_state.dart';
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

  List<Ingredient> getIngredients() => state.ingredients;

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
