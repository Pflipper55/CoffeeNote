import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/recipes/grind_degree.dart';
import 'package:coffee_note/models/steps/recipe_step.dart';

class RecipeNote {
  final int id;
  final String title;
  final String description;
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;
  final Duration brewTime;
  final GrindDegree grindDegree;
  final double brewTemperature; // In Celcius
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RecipeNote({
    required this.id,
    required this.title,
    this.description = '',
    this.ingredients = const [],
    this.steps = const [],
    this.brewTime = const Duration(),
    this.grindDegree = GrindDegree.medium,
    this.brewTemperature = 0.0,
    this.notes = '',
    required this.createdAt,
    required this.updatedAt,
  });
}