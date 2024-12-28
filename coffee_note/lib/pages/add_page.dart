import 'package:coffee_note/models/ingredient.dart';
import 'package:coffee_note/providers/ingridient_provider.dart';
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
                onPressed: _openIngredientModal,
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

  Future<void> _openIngredientModal() async {
    final allIngredients = ref.watch(allIngredientProvider);
    Map<int, bool> selectBoxItems = {
      for(var item in allIngredients) item.id:false
    };
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) =>
          AlertDialog(
            title: Text("Select Ingredients"),
            content: ListView.builder(
              key: UniqueKey(),
              itemCount: selectBoxItems.length,
              itemBuilder: (context, index) { 
                final ingredient = allIngredients[index];
                return CheckboxListTile(
                  key: Key(ingredient.id.toString()),
                  value: selectBoxItems[index],
                  onChanged: (value) {
                    setState(() {
                      selectBoxItems[index] = value!;
                    });
                  },
                  title: Text(allIngredients[index].name),
                );
              }
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Add")
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel")
              )
            ],
          ),
        );
      }
    );
  }
}