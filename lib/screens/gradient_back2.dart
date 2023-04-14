import 'package:flutter/material.dart';

class GradientBack2 extends StatelessWidget {
  @override
  String title = "Popular";
  GradientBack2(this.title);
  Widget build(BuildContext context) {
    // TODO: implement build
return Column(children: [Container(
  height:300,
  decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFFFFFF),
          Color(0xFFFFFFFF),
        ],
        begin: FractionalOffset(0.2, 0.0),
        end: FractionalOffset(1.0, 0.6),
        stops: [0.0, 0.6],
        tileMode: TileMode.clamp,

      )
  ),
  child: Text(title,
      textAlign: TextAlign.center,
      style: TextStyle(

        color: Colors.white,
        fontSize: 30,
        fontFamily: "Lato",
        fontWeight: FontWeight.bold,

      )),
  alignment: Alignment(0, 0.3),
),Container(
  height:280,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF8D0E57),
          Color(0XFF7e0c4e),
        ],
        begin: FractionalOffset(0.2, 0.0),
        end: FractionalOffset(1.0, 0.6),
        stops: [0.0, 0.6],
        tileMode: TileMode.clamp,

      )
    ),
  child: Text(title,
  textAlign: TextAlign.center,
  style: TextStyle(

    color: Colors.white,
    fontSize: 30,
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,

  )),
  alignment: Alignment(0, 0.3),
),]);

  }


}