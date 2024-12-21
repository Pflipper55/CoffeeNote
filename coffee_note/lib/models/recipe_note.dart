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

  RecipeNote({
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'ingredients': ingredients.map((e) => e.toJson()).toList(),
    'steps': steps,
    'brewTime': brewTime,
    'brewTemperature': brewTemperature,
    'notes': notes,
    'rating': rating,
    'tags': tags,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory RecipeNote.fromJson(Map<String, dynamic> json) => RecipeNote(
    id: json['id'],
    title: json['title'],
    description: json['description'] ?? '',
    ingredients: (json['ingredients'] as List)
      .map((e) => Ingredient.fromJson(e))
      .toList(),
    steps: List<String>.from(json['steps'] ?? []),
    brewTime: json['brewTime'] ?? 0,
    brewTemperature: (json['brewTemperature'] ?? 0.0).toDouble(),
    notes: json['notes'] ?? '',
    rating: json['rating'] ?? 0,
    tags: List<String>.from(json['tags'] ?? []),
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );
}