import 'package:coffee_note/models/ingredients/ingredient.dart';

class RecipeAddFormState {
  final String title;
  final String description;
  final List<Ingredient> ingredients;
  final List<String> steps;
  final int brewTime;
  final double brewTemperature;
  final String notes;

  RecipeAddFormState({
    this.title = '',
    this.description = '',
    this.ingredients = const [],
    this.steps = const [],
    this.brewTime = 0,
    this.brewTemperature = 0.0,
    this.notes = '',
  });

  RecipeAddFormState copyWith({
    String? title,
    String? description,
    List<Ingredient>? ingredients,
    List<String>? steps,
    int? brewTime,
    double? brewTemperature,
    String? notes,
  }) {
    return RecipeAddFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      brewTime: brewTime ?? this.brewTime,
      brewTemperature: brewTemperature ?? this.brewTemperature,
      notes: notes ?? this.notes,
    );
  }
}