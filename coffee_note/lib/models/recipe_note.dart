import 'package:coffee_note/models/ingredient.dart';

class RecipeNote {
  final int id;
  final String title;
  final String description;
  final List<Ingredient> ingredients;
  final List<String> steps;
  final int brewTime;
  final double brewTemperature; // In Celcius
  final String notes;
  final int rating; // 1-5
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RecipeNote({
    required this.id,
    required this.title,
    this.description = '',
    this.ingredients = const [],
    this.steps = const [],
    this.brewTime = 0,
    this.brewTemperature = 0.0,
    this.notes = '',
    this.rating = 0,
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
  });
}