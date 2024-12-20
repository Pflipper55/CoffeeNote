import 'package:coffee_note/helpers/color_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getPrimaryColor(),
        title: Text(
          widget.title,
          style: TextStyle(
            color: getWhiteSmoke(),
          ),
        ),
      ),
      body: _homeGrid()
    );
  }

  Widget _homeGrid() => GridView.count(
    padding: EdgeInsets.all(10),
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    children: _buildGrid()
  );
  
  List<Widget> _buildGrid() => [
    _buildCardButton(Icons.add, getSecondaryColor(), "Add note", _navigateToAddPage),
    _buildCardButton(Icons.search, getTaupeGray(), "See all notes", _navigateToSearchPage),
  ];

  Widget _buildCardButton(IconData icon, Color iconColor, String iconText, void Function() tapFunction) 
    => GestureDetector(
      onTap: tapFunction,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 50,
            ),
            Text(
              iconText,
              style: TextStyle(
                fontSize: 20
              ),
            )
          ],
        ),
      )
    );


  void _navigateToAddPage() {
  }

  void _navigateToSearchPage() {
  }
}