import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return _homeGrid();
  }

  Widget _homeGrid() => GridView.count(
    padding: EdgeInsets.all(10),
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    children: _buildGrid()
  );
  
  List<Widget> _buildGrid() => [];


}