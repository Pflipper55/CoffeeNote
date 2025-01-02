enum GrindDegree {
  rough,
  mediumRough,
  medium,
  mediumFine,
  fine
}

extension GrindDegreeExtension on GrindDegree {
  String get displayName {
    switch (this) {
      case GrindDegree.rough:
        return "rough";
      case GrindDegree.mediumRough:
        return "medium rough";
      case GrindDegree.medium:
        return "medium";
      case GrindDegree.mediumFine:
        return "medium fine";
      default:
        return "fine";
    }
  }

}
