
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'color.dart';

class Bienvenue extends StatefulWidget {
Bienvenue(this.name,this.sizeScreen, this.sizeScreenW);
String name="";
double sizeScreen;
double sizeScreenW;
  @override
  State<StatefulWidget> createState() =>_Bievenue();


}
double responsiveFontSize(BuildContext context, double scaleFactor) {
  final double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth * scaleFactor;
}
class _Bievenue extends State<Bienvenue>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryColor: color
      ),
      home: Scaffold(
        body: Center(child:Column(mainAxisAlignment: MainAxisAlignment.center,children:[Container(alignment: Alignment.center,  width: widget.sizeScreenW,
            decoration:BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color,
                    Color(0XFF7e0c4e),
                  ],
                  begin: FractionalOffset(0.2, 0.0),
                  end: FractionalOffset(1.0, 0.6),
                  stops: [0.0, 0.6],
                  tileMode: TileMode.clamp,

                )
            ),child:Text(style: TextStyle(fontSize:responsiveFontSize(context, 0.05),color: Colors.white), textAlign: TextAlign.center,"Bienvenue ${widget.name}")),
          Lottie.network(
            'https://assets8.lottiefiles.com/packages/lf20_PBIF1bbXZ0.json', // chemin vers votre fichier Lottie
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(style: TextStyle(fontSize:responsiveFontSize(context, 0.035),color: Colors.black), textAlign: TextAlign.justify,"\n\nJe suis content de vous présenter cette première version, un espace dédié pour développer vos compétences essentielles en langue française,  telles que la production orale,  la production écrite, et la compréhension orale.   "
    "\n\n Ainsi, vous pourrez accéder à tous les  cours auxquels vous êtes inscrit à la  sorbonne Nouvelle (DULF, DUEF 1, DUEF2),  et même aux  sujets proposés par vos enseignants. Vous trouverez un espace pour télétransmettre des enregistrements et des images sur un sujet donné. Vous choisissez un audio et une image  qui correspondent  à la question proposée par l"+"'"+"enseignant. "+" \n\nL"+"’" +"application est régulièrement mise à jour avec de nouvelles fonctionnalités pour que vous puissiez continuer à apprendre. Si vous avez des questions ou des commentaires sur ce projet, n"+"'"+"hésitez pas à  me contacter par mail jhan-mauricio.diaz-pico@sorbonne-nouvelle.fr."
    ))])),
      ),
    );
  }

}