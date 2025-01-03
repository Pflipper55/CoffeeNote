import 'package:coffee_note/models/misc/form_list_model.dart';
import 'package:flutter/material.dart';

class FormListWidget<T> extends StatefulWidget {
  final FormListModel<T> model;

  const FormListWidget({
    super.key,
    required this.model,
  });

  @override
  _FormListWidgetState<T> createState() => _FormListWidgetState<T>();
}

class _FormListWidgetState<T> extends State<FormListWidget<T>> {
  late List<T> models;

  @override
  void initState() {
    super.initState();
    models = widget.model.models;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Text(
              widget.model.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 100,
          child: widget.model.buildListTile(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              flex: 1,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => widget.model.addModal,
                  ).then((value) {
                    setState(() {
                      models = widget.model.models;
                    });
                  });
                },
                icon: Icon(Icons.add),
                label: Text(widget.model.addButtonText),
              ),
            ),
            Flexible(
              flex: 1,
              child: ElevatedButton.icon(
                onPressed: widget.model.canRemove()
                    ? () async {
                        await showDialog(
                          context: context,
                          builder: (context) => widget.model.removeModal,
                        ).then((value) {
                          setState(() {
                            models = widget.model.models;
                          });
                        });
                      }
                    : null,
                icon: Icon(Icons.delete_outlined),
                label: Text(widget.model.removeButtonText),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
