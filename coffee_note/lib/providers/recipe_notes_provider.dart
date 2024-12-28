import 'package:coffee_note/models/recipes/recipe_note.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// ToDo: Remove
final testDescription = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";

List<RecipeNote> recentNotes = [
  RecipeNote(
    id: 0,
    title: "Lorem Ipsum 0",
    description: testDescription,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now()
  ),
  RecipeNote(
    id: 1,
    title: "Lorem Ipsum 1",
    description: testDescription,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now()
  ),
  RecipeNote(
    id: 2,
    title: "Lorem Ipsum 2",
    description: testDescription,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now()
  ),
];

@riverpod
final recentNotesProvider = Provider((ref) => recentNotes);