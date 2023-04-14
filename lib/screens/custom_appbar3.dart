
import 'package:flutter/material.dart';

class CustomAppBar3 extends StatelessWidget {
  CustomAppBar3(this.size, this.sizeW, this.context2);
  double size;
  double sizeW;
  final BuildContext context2;
  @override
  Widget build(BuildContext context) {

    final iconAppBar = Container(
        height: size,
        padding: EdgeInsets.only(
            top: size*0.32,
            left: size*0.10
        ),
        child: InkWell(
          onTap: (){
            Navigator.popUntil(context, ModalRoute.withName('/'));


          },
          child: Column(
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Icon(
                  Icons.logout,
                  color: Colors.white
              )
            ],
          ),
        )
    );// iconAppBar Container



    final titleBar = Container(
      margin: EdgeInsets.only(
          top: size*0.25
      ),
      alignment: Alignment.center,
      child: Text(
        "Sorbonne Nouvelle",
        style: TextStyle(
          color: Colors.white,
          fontSize: size*0.20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );// titleBar Container

    var imageBar = Container(
      height: size,
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
    );

    return Stack(
      children: <Widget>[

        imageBar,

        titleBar

      ],
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 40.0);

    var firstControlPoint = new Offset(size.width / 6, size.height - 50);

    var firstEndPoint = new Offset(size.width / 3, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = new Offset( size.width * 0.51, size.height);

    var secondEndPoint = new Offset(size.width * (4 / 6), size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = new Offset(size.width * (5 / 6), size.height - 60);

    var thirdEndPoint = new Offset(size.width, size.height - 40.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(size.width, size.height - 40.0);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}