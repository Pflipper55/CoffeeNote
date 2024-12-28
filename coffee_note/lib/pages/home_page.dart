import 'package:coffee_note/models/recipes/recipe_note.dart';
import 'package:coffee_note/providers/recipe_notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(recentNotesProvider);
    return _homeColumn(notes);
  }

  Widget _homeColumn(List<RecipeNote> notes) => Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 20, left: 20),
        child: Row(
          children: [
            Text(
              "Recent Notes",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w200
              ),
            ),
          ],
        ), 
      ),       
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: _buildCarousel(notes),
      ),     
    ],
  );
  
  _buildCarousel(List<RecipeNote> notes) => CarouselView(
    itemSnapping: true,
    scrollDirection: Axis.horizontal,
    onTap: _openNote(), // ToDo Get Element
    itemExtent: double.infinity,
    shrinkExtent: 300,
    children: _buildCarouselItems(notes),
  );
  
  List<Widget> _buildCarouselItems(List<RecipeNote> notes) {
    List<Widget> widgets = [];
    for (var note in notes) {
      final title = note.title;
      final description = note.description;
      widgets.add(
        Card(
          child: InkWell(
            onTap: _openNote,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(                     
                      Icons.receipt,
                      size: 40,
                      applyTextScaling: false,
                    ),
                    title: 
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    subtitle: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      description
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }
  
  _openNote() {

  }
}