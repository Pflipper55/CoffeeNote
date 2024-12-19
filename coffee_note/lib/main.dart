import 'package:flutter/material.dart';
import 'package:super_hero_v2/super_hero_v2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My SuperHero Picker",
      home: SuperHeroNameGenerator(),
    );
  }
}

class SuperHeroNameGenerator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SuperHeroName();
}

class _SuperHeroName extends State<SuperHeroNameGenerator>{
  final _superHeroNames = <String>[]; // String list
  final _hearted = <String>{};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome to my SuperHero Picker"),
        ),
        body: Center(
          child: _buildBody(),
        ),
      );
  }
  
  Widget _buildBody() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (context , i) {
        if(i.isOdd){
          return Divider();
        }
        if(i ~/ 2 >= _superHeroNames.length){
          _superHeroNames.addAll(_generateSuperHeroNames());
        }
        return _buildRow(_superHeroNames[i ~/ 2]);
      }
    );
  }
  
  Iterable<String> _generateSuperHeroNames() {
    List<String> myNames = List.empty(growable: true);
    for(int i = 0; i < 10; i++){
      myNames.add(SuperHero.random());
    }
    return myNames;
  }
  
  Widget _buildRow(String superHeroName) {
    final _markedFav = _hearted.contains(superHeroName);
    return ListTile(
      title: Text(superHeroName),
      trailing: Icon(
        _markedFav ? Icons.favorite : Icons.favorite_border,
        color: _markedFav ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          _markedFav ? _hearted.remove(superHeroName) : _hearted.add(superHeroName);
        });
      },
      onLongPress: () => _pushExample(superHeroName),
    );
  }

  void _pushExample(String superHeroName) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) {
        final _superHeroName = superHeroName;
        return Scaffold(
          appBar: AppBar(
            title: Text(_superHeroName),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network('https://picsum.photos/100'),
                  Image.network('https://picsum.photos/100'),
                  Image.network('https://picsum.photos/100'),
                  Image.network('https://picsum.photos/100'),
                  Image.network('https://picsum.photos/100'),
                ],
              ),
              Text(_superHeroName)
            ] // children
          ),
        );
      }),
    );
  }
}