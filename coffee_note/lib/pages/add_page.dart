import 'package:coffee_note/misc/modals/ingredients/add_ingredient_modal.dart';
import 'package:coffee_note/misc/modals/ingredients/remove_ingredient_modal.dart';
import 'package:coffee_note/misc/modals/ingredients/update_ingredient_modal.dart';
import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/ingredients/ingredient_units.dart';
import 'package:coffee_note/models/recipes/recipe_add_form_state.dart';
import 'package:coffee_note/providers/recipe_add_form_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  RecipeAddFormState state = RecipeAddFormState();
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    state = ref.watch(recipeIngredientNotifierProvider);
    titleController.text = state.title;
    descriptionController.text = state.description;


    return _buildAddForm(state);
  }
  
  Widget _buildAddForm(RecipeAddFormState state) => Form(
    key: _formKey,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0),
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            onChanged: (value) {
              ref.watch(recipeIngredientNotifierProvider.notifier).updateTitle(titleController.text);
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Enter the title of the recipe"
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            onChanged: (value) {
              ref.watch(recipeIngredientNotifierProvider.notifier).updateDescription(descriptionController.text);
            },
            maxLines: 5,
            maxLength: 120,
            decoration: InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: _buildIngredientListTile(state.ingredients)
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,     
            spacing: 8,   
            children: [
              Flexible(
                flex: 1,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => AddIngredientModal(ref: ref)
                    );
                  },
                  icon: Icon(
                    Icons.add
                  ),
                  label: Text("Add Ingredient"),
                ),
              ),
              Flexible(
                flex: 1,
                child: ElevatedButton.icon(
                  onPressed: ref.watch(recipeIngredientNotifierProvider).ingredients.isNotEmpty 
                  ? () async {
                    await showDialog(
                      context: context,
                      builder: (context) => RemoveIngredientModal(ref: ref)
                    );
                  }
                  : null,
                  icon: Icon(
                    Icons.delete_outlined
                  ),
                  label: Text(
                    "Delete Ingredient",
                  ),
                ),
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
              ref.watch(recipeIngredientNotifierProvider.notifier).removeIngredient(item);
            });
          },
          background: Container(color: Colors.red,),
          child: ListTile(
            title: Text(item.name),     
            subtitle: Text("${item.amount} ${item.unit.displayName}"),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => EditIngredientModal(ref: ref, ingredient: item)
              );
            },
          )
        );
      },
    );
  }

}