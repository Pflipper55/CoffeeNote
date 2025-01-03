import 'package:coffee_note/models/recipes/recipe_add_form_state.dart';
import 'package:coffee_note/providers/notifiers/recipe_add_form_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider für den RecipeAddFormState.
final recipeIngredientNotifierProvider =
    NotifierProvider<RecipeAddFormStateNotifier, RecipeAddFormState>(
  () => RecipeAddFormStateNotifier(),
);
