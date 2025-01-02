import 'package:coffee_note/helpers/color_helper.dart';
import 'package:coffee_note/pages/add_page.dart';
import 'package:coffee_note/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Notepad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: getPrimaryColor()),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          appBar: _buildAppBar(),
          bottomNavigationBar: _buildMenu(),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              AddPage(), // ToDo Replace to AddPage
              HomePage(),
              Container() // ToDo Replace to SearchPage
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
    centerTitle: true,
  );

  Widget _buildMenu() => Container(
    color: getPrimaryColor(),
    child: _buildTabBar(),
  );

  TabBar _buildTabBar() => TabBar(
    padding: EdgeInsets.all(4),
    dividerColor: Colors.transparent,
    indicatorColor: Colors.white,
    unselectedLabelColor: Colors.white,
    labelColor: Colors.white,
    tabs: [
      Tab(
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
        text: "Add Note",
      ),
      Tab(
        icon: Icon(
          Icons.home,
          color: Colors.white,
          size: 30,
        ),
        text: "Home",
      ),
      Tab(
        icon: Icon(
          Icons.search,
          color: Colors.white,
          size: 30,
        ),
        text: "Search",
      )
    ]
  );
}




