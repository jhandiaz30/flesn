import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _FloatingActionButtonGreen();
  }


  }




class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen>{
  void onPressedFav() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Navegando")),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      backgroundColor: Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav",
      onPressed: onPressedFav,
      child: Icon(
        Icons.favorite_border
      ),
    );
  }

}