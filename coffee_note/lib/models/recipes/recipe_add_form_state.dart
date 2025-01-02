import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/recipes/grind_degree.dart';
import 'package:coffee_note/models/steps/recipe_step.dart';

class RecipeAddFormState {
  String title;
  String description;
  List<Ingredient> ingredients;
  List<RecipeStep> steps;
  Duration brewTime;
  GrindDegree grindDegree;
  double brewTemperature;
  String notes;


  RecipeAddFormState({
    this.title = '',
    this.description = '',
    this.ingredients = const [],
    this.steps = const [],
    this.brewTime = const Duration(),
    this.grindDegree = GrindDegree.medium,
    this.brewTemperature = 0.0,
    this.notes = '',
  });

  RecipeAddFormState copyWith({
    String? title,
    String? description,
    List<Ingredient>? ingredients,
    List<RecipeStep>? steps,
    Duration? brewTime,
    GrindDegree? grindDegree,
    double? brewTemperature,
    String? notes,
  }) {
    return RecipeAddFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      brewTime: brewTime ?? this.brewTime,
      grindDegree: grindDegree ?? this.grindDegree,
      brewTemperature: brewTemperature ?? this.brewTemperature,
      notes: notes ?? this.notes,
    );
  }
}