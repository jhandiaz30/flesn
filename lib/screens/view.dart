import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  @override

  String url_image ;
  String name ;
  String details ;

  double sizeScreen;
  double sizeScreenW;
  Review(this.url_image, this.name, this.details, this.sizeScreen, this.sizeScreenW);

  double responsiveFontSize(BuildContext context, double scaleFactor) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * scaleFactor;
  }
  Widget build(BuildContext context) {
    // TODO: implement build


    final photo = Container(

      margin: EdgeInsets.only(
        top: sizeScreen*0.0214,
        left: sizeScreenW*0.05,
      ),
      width: sizeScreenW*0.15,
      height: sizeScreen*0.15,


        child:

        CircleAvatar(
          radius: sizeScreen*0,
          backgroundImage: NetworkImage(url_image),

        )
    );

    final userName = Container(
      margin: EdgeInsets.only(
        left:sizeScreenW*0.04
      ),
      child: Text(name,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: responsiveFontSize(context, 0.035),
          fontFamily: "Lato",
        ),

      ),
    );

    final userInfo = Container(
      margin: EdgeInsets.only(
          left: sizeScreenW*0.04,
      ),
      child: Text(details,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: responsiveFontSize(context, 0.035),
          fontFamily: "Lato",

          color: Colors.black,

        ),

      ),
    );


final userDetails = Container(


    child:Column(

  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
userName,
    userInfo,

  ],
));

    return Container(  child:Row(


      children: <Widget>[
        photo,
        userDetails
      ],
    ));
  }

}
