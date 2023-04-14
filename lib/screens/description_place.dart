import 'package:flutter/material.dart';
import 'button_purple.dart';


class DescriptionPlace extends StatelessWidget{
  @override
  String title;
  String description;
  int etoiles;
  DescriptionPlace(this.title, this.description, this.etoiles);

  Widget build(BuildContext context) {

    // TODO: implement build
    String url_image ="assets/images/jesus.jpeg";

    final starts = Container(

      margin: EdgeInsets.only(
        top: 320,
        left: 2,
        right: 2,
      ),
        child :Icon(Icons.star,
          color: Colors.amber),


    );





    final description_place =

  Container(
    margin: EdgeInsets.only(
      top: 30,
        left: 20,
        right: 20
    ),
    child: Text(description,
    maxLines: 10,

    style: TextStyle(
      color: Colors.black,
      fontFamily: "Lato",
      fontSize: 14,

    ),),
  );


    final tittle_starts =
    Column(children: <Widget>[ Row(
      children: <Widget>[
        Container(
margin: EdgeInsets.only(
top: 320,
  left: 20,
  right: 20,
),
          child: Text(title,
           style: TextStyle(

             fontSize: 30,
             fontWeight: FontWeight.w900,
           ),
         textAlign: TextAlign.left,
          ),

        ),
Row(
  children: [
    starts,
    starts,
    starts,
    starts,
    starts,

  ],
),


      ],
    ),

    ],

    );


return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    tittle_starts,
    description_place,
    ButtonPurple("Navigate"),
  ],
);

  }

}