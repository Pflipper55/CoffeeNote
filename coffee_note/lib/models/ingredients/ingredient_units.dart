enum IngredientUnits {
  gram,          // g
  kilogram,      // kg
  milliliter,    // ml
  liter,         // l
  teaspoon,      // tsp
  tablespoon,    // tbsp
  piece,         // Stück
  cup,           // Tasse
  pinch,         // Prise
  ounce,         // oz
  pound,         // lb
}
extension IngredientUnitExtension on IngredientUnits {
  String get displayName {
    switch (this) {
      case IngredientUnits.gram:
        return "Gram (g)";
      case IngredientUnits.kilogram:
        return "Kilogram (kg)";
      case IngredientUnits.milliliter:
        return "Milliliter (ml)";
      case IngredientUnits.liter:
        return "Liter (l)";
      case IngredientUnits.teaspoon:
        return "Teaspoon (tsp)";
      case IngredientUnits.tablespoon:
        return "Tablespoon (tbsp)";
      case IngredientUnits.piece:
        return "Piece";
      case IngredientUnits.cup:
        return "Cup";
      case IngredientUnits.pinch:
        return "Pinch";
      case IngredientUnits.ounce:
        return "Ounce (oz)";
      case IngredientUnits.pound:
        return "Pound (lb)";
    }
  }
}