import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => _buildAddForm();
  
  Widget _buildAddForm() => Form(
    key: _formKey,
    child: Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Enter the title of the recipe"
          ),
        ),
      ],
    )
  );
}