import 'package:flutter/material.dart';
import 'view.dart';
class ReviewList extends StatelessWidget{
  ReviewList(this.image,this.name,this.description,this.sizeScreen, this.sizeScreenW);
  var name;
  var description;
  var image;
  double sizeScreen;
  double sizeScreenW;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Column(
crossAxisAlignment: CrossAxisAlignment.center,
      children: [

         Review(image, name, description,sizeScreen,sizeScreenW),

      ],

    );


  }

}