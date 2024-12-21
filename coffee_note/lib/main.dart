import 'package:coffee_note/helpers/color_helper.dart';
import 'package:coffee_note/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Notepad',
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: _buildAppBar(),
          bottomNavigationBar: _buildMenu(),
          body: TabBarView(
            children: [
              HomePage()
            ]
          ),
        )
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
    backgroundColor: getPrimaryColor(),
    title: Text(
      "Coffee Notepad",
      style: TextStyle(
        color: getWhiteSmoke(),
      ),
    ),
  );

  Widget _buildMenu() => Container(
    color: getPrimaryColor(),
    child: _buildTabBar(),
  );

  TabBar _buildTabBar() => TabBar(
    padding: EdgeInsets.all(4),
    dividerColor: Colors.transparent,
    indicatorColor: Colors.white,
    tabs: [
      Tab(
        icon: Icon(
          Icons.home,
          color: Colors.white,
          size: 30,
        ),
      )
    ]
  );
}




