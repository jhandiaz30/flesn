import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {
  @override
  String title = "Popular";
  double sizeScreen;
  double sizeW;

  double responsiveFontSize(BuildContext context, double scaleFactor) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * scaleFactor;
  }
  GradientBack(this.title,this.sizeScreen, this.sizeW);

  Widget build(BuildContext context) {
    // TODO: implement build
return Container(
  padding: EdgeInsets.symmetric(vertical: sizeScreen*0.0214,horizontal: sizeScreen*0.0214),
  height:sizeScreen*0.38,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF8D0E57),
        Color(0XFF7e0c4e),
        ],
        begin: FractionalOffset(sizeW*0.02145, 0.0),
        end: FractionalOffset(sizeW*0.010729, sizeW*0.064377),
        stops: [0.0, sizeW*0.064377],
        tileMode: TileMode.clamp,

      )
    ),
  child: Center( child:Text(title,
  textAlign: TextAlign.justify,
  style: TextStyle(

    color: Colors.white,
    fontSize: responsiveFontSize(context, 0.035),
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,

  ))),
  alignment: Alignment(0, sizeScreen*0.0007),
);

  }


}