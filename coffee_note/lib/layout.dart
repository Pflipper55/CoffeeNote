import 'dart:convert';

import 'package:coffee_note/bitcoinPrice.dart';
import 'package:coffee_note/networking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Widget mainWidget(){
  return materialCard();
}

Widget materialCard() {
  return SizedBox(
    height: 240,
    child: Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Danke fürs Zusehen",
              style: TextStyle(
                fontWeight: FontWeight.w400
              ),
            ),
            subtitle: FutureBuilder<http.Response>(
              future: fetchBitcoinPrice(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  int statusCode = snapshot.data!.statusCode;
                  if(statusCode == 200) {
                    return Text(BitcoinPrice.fromJson(jsonDecode(snapshot.data!.body)).euro.toString());
                  }
                  return Text(statusCode.toString());
                }
                else if(snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }
            ),
            leading: Icon(
              Icons.star_rate,
              color: Colors.blue[500]
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "Danke fürs Zusehen",
              style: TextStyle(
                fontWeight: FontWeight.w400
              ),
            ),
            subtitle: Text("Lasst gerne eine positive Bewertung hier"),
            leading: Icon(
              Icons.star_rate,
              color: Colors.blue[500]
            ),
          ),
        ],
      ),
    ),
  );
}

Widget gridView() {
  return GridView.extent(
    maxCrossAxisExtent: 150,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: _buildGridList(25),
  );
}

List<Widget> _buildGridList(int i) {
  return List.generate(
    i,
   (index) => Stack(
      alignment: const Alignment(0, 1),
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('https://picsum.photos/150'),
          radius: 250,
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.black38
          ),
          child: 
            Text(
              "Text",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white70
              ),
            )
        )
      ],
   )
  );
}

Widget container() {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFF9000),
        border:  Border.all(
          color: const Color(0xFF000000),
          width: 5
          ),
        borderRadius: BorderRadius.circular(4)
      ),
      margin: const EdgeInsets.all(4),
      child: Image.network('https://picsum.photos/100'),
    )
  );
}