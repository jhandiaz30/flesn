import 'package:flutter/material.dart';
import 'floating_action_button_green.dart';

class CardImage extends StatelessWidget {
  @override

  String pathImage ="assets/images/colombie.jpeg";
  double sizeScreen;
  double sizeScreenW;
  CardImage(this.pathImage, this.sizeScreen, this.sizeScreenW);
  Widget build(BuildContext context) {
    // TODO: implement build

    final card = Container(
      height: sizeScreen*0.40,
      width: sizeScreenW*0.80,
      margin: EdgeInsets.only(
        top: sizeScreen*0.23,
          left: sizeScreen*0.025
      ),
      decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
          image: NetworkImage(pathImage),
      ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 15,
            offset: Offset(0.0, 0.7)

          )
        ]
    ),
    );
   return Stack(

     children: [
       card,

     ],
   );
  }
  
}