import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/providers/recipe_ingredient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  @override
  void initState() {
    super.initState();
  }

  String recipeTitle =  "";
  String recipeDescription = '';
  List<Ingredient> recipeIngredients = [];
  List<String> steps = [];
  int brewTime = 0;
  double brewTemperature = 0.0;
  String notes = '';
  int rating = 0;
  List<String> tags = [];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => _buildAddForm();
  
  Widget _buildAddForm() => Form(
    key: _formKey,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Enter the title of the recipe"
            ),
          ),
          TextFormField(
            maxLines: 5,
            maxLength: 120,
            decoration: InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            children: [
              Text("Ingredients:"),
            ],
          ),
          SizedBox(
            height: 100,
            child: _buildIngredientListTile([])
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // ToDo show ingredient
                },
                icon: Icon(
                  Icons.add
                ),
                label: Text("Add Ingredients"),
              ),
            ],
          )
        ],
      ),
    )
  );
  
  Widget _buildIngredientListTile(List<Ingredient> ingredients) {
    return ListView.builder(
      key: UniqueKey(),
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final item = ingredients[index];
        return  Dismissible(
          key: Key('$index'),
          onDismissed: (direction) {
            setState(() {
              ingredients.removeAt(index);
            });
          },
          background: Container(color: Colors.red,),
          child: ListTile(
            title: Text(item.name),         
          )
        );
      },
    );
  }

}