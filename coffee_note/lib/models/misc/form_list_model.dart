import 'package:flutter/material.dart';

class FormListModel<T> {
  final String title;
  final List<T> models;
  final Widget addModal;
  final Widget removeModal;
  final String addButtonText;
  final String removeButtonText;
  final Widget Function(List<T>) buildListTile;
  final bool Function() canRemove;

  FormListModel({
    required this.title,
    required this.models,
    required this.addModal,
    required this.removeModal,
    required this.addButtonText,
    required this.removeButtonText,
    required this.buildListTile,
    required this.canRemove,
  });
}
