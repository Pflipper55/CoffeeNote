import 'package:flutter/material.dart';

Widget mainWidget(){
  return Row(
    children: [
      container(),
      container()
    ],
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
      child: Image.network('https://picsum.photos/100'),
      margin: const EdgeInsets.all(4),
    )
  );
}