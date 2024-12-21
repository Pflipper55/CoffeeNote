class Ingredient {
  final int id;
  final String name;
  final double amount;
  final String unit;

  const Ingredient({required this.id, required this.name, required this.amount, required this.unit});

   Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'amount': amount,
      'unit': unit,
    };

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    id: json['id'],
    name: json['name'],
    amount: json['amount'],
    unit: json['unit'],
  );
}