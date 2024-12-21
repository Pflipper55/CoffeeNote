import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return _homeColumn();
  }

  Widget _homeColumn() => Column(
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
        child: _buildCarousel(),
      ),     
    ],
  );
  
  _buildCarousel() => CarouselView(
    scrollDirection: Axis.horizontal,
    onTap: _openNote(), // ToDo Get Element
    itemExtent: double.infinity,
    children: _buildCarouselItems(),
  );
  
  List<Widget> _buildCarouselItems() => [
    Center(child: Text('Item 1')),
    Center(child: Text('Item 2')),
    Center(child: Text('Item 3')),
  ];
  
  _openNote() {

  }
  
}