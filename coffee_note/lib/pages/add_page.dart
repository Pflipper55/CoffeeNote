import 'package:coffee_note/widgets/modals/ingredients/add_ingredient_modal.dart';
import 'package:coffee_note/widgets/modals/ingredients/remove_ingredient_modal.dart';
import 'package:coffee_note/widgets/modals/ingredients/update_ingredient_modal.dart';
import 'package:coffee_note/widgets/modals/recipe_steps/add_recipe_steps_modal.dart';
import 'package:coffee_note/widgets/modals/recipe_steps/remove_recipe_steps_modal.dart';
import 'package:coffee_note/widgets/modals/recipe_steps/update_recipe_steps_modal.dart';
import 'package:coffee_note/widgets/misc/form_list_widget.dart';
import 'package:coffee_note/models/ingredients/ingredient.dart';
import 'package:coffee_note/models/ingredients/ingredient_units.dart';
import 'package:coffee_note/models/misc/form_list_model.dart';
import 'package:coffee_note/models/recipes/recipe_add_form_state.dart';
import 'package:coffee_note/models/steps/recipe_step.dart';
import 'package:coffee_note/providers/recipe_add_form_state_provider.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  RecipeAddFormState state = RecipeAddFormState();
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  late FormListModel<Ingredient> _formListIngredients;
  late FormListModel<RecipeStep> _formListSteps;

  @override
  Widget build(BuildContext context) {
    state = ref.watch(recipeIngredientNotifierProvider);
    _titleController.text = state.title;
    _descriptionController.text = state.description;
    Duration _brewTime = state.brewTime;

    _formListSteps = FormListModel(
      title: "Steps",
      buildListTile: _buildStepListTile,
      models: ref.watch(recipeIngredientNotifierProvider).steps,
      addModal: AddRecipeStepsModal(ref: ref),
      removeModal: RemoveRecipeStepModal(ref: ref),
      addButtonText: "Add Steps",
      removeButtonText: "Remove Steps",
      canRemove: () => ref.watch(recipeIngredientNotifierProvider).steps.isNotEmpty,);
    
    _formListIngredients = FormListModel(
      title: "Ingredients",
      buildListTile: _buildIngredientListTile,
      models: ref.watch(recipeIngredientNotifierProvider).ingredients,
      addModal: AddIngredientModal(ref: ref),
      removeModal: RemoveIngredientModal(ref: ref),
      addButtonText: "Add Ingredients",
      removeButtonText: "Remove Ingredients",
      canRemove: () => ref.watch(recipeIngredientNotifierProvider).steps.isNotEmpty);

    return _buildAddForm(state);
  }
  
  Widget _buildAddForm(RecipeAddFormState state) => Form(
    key: _formKey,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              onChanged: (value) {
                ref.watch(recipeIngredientNotifierProvider.notifier).updateTitle(_titleController.text);
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Enter the title of the recipe"
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              onChanged: (value) {
                ref.watch(recipeIngredientNotifierProvider.notifier).updateDescription(_descriptionController.text);
              },
              maxLines: 5,
              maxLength: 120,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            FormListWidget(model: _formListIngredients),
            SizedBox(height: 30),
            FormListWidget(model: _formListSteps),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 30.0,
                  children: [
                    Text(
                      "Brew time",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text("${ref.watch(recipeIngredientNotifierProvider).brewTime}"),
                  ]
                ),
                FloatingActionButton(
                  onPressed: () async {
                    var resultingDuration = await showDurationPicker(
                      baseUnit: BaseUnit.second,
                      context: context,
                      initialTime: Duration(seconds: 0)
                    );
                    setState(() {
                      var oldValue = ref.read(recipeIngredientNotifierProvider).brewTime;
                      ref.read(recipeIngredientNotifierProvider.notifier).updateBrewTime(resultingDuration ?? oldValue);
                    });
                  },
                  tooltip: "Set brew time",
                  child: Icon(Icons.punch_clock),
                )
 
              ]
            )
          ],
        ),
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

  Widget _buildStepListTile(List<RecipeStep> steps)
    => ListView.builder(
      key: UniqueKey(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final item = steps[index];
        return  Dismissible(
          key: Key('$index'),
          onDismissed: (direction) {
            setState(() {
              ref.watch(recipeIngredientNotifierProvider.notifier).removeStep(item);
            });
          },
          background: Container(color: Colors.red,),
          child: ListTile(
            title: Text(item.description),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => EditRecipeStepModal(ref: ref, step: item)
              );
            }, 
          )
        );
      },
    );

}