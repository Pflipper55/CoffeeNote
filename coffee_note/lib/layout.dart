import 'package:flutter/cupertino.dart'

Widget mainWidget(){
  return Row(
    children: [
      Image.network('https://picsum.photos/100'),
      Image.network('https://picsum.photos/100'),
      Image.network('https://picsum.photos/100'),
    ],
  );
}