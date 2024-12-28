import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:const_date_time/const_date_time.dart';

class RecipeNote {
  final int id;
  final String title;
  final String description;
  final List<Ingredient> ingredients;
  final List<String> steps;
  final DateTime brewTime;
  final double brewTemperature; // In Celcius
  final String notes;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RecipeNote({
    required this.id,
    required this.title,
    this.description = '',
    this.ingredients = const [],
    this.steps = const [],
    this.brewTime = const ConstDateTime(0),
    this.brewTemperature = 0.0,
    this.notes = '',
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
  });
}