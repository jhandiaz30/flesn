
import 'package:flesn/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'color.dart';
import 'SongsPage.dart';
import 'custom_appbar.dart';


class Comments extends StatefulWidget {
  const Comments( this.nameU, this.idTopic, this.idCours, this.nameUser, this.image, this.sizeScreen, this.sizeScreenW,this.audio,this.nameC,this.description,this.position,
  {Key? key}) : super(key: key);
final int position;
 final String image;

  final String description;
  final String nameU;
  final String nameC;

  final String nameUser;
  final  idTopic;
  final  idCours;
  final audio;
  final double sizeScreen;
  final double sizeScreenW;



  @override
  State<Comments> createState() => _State();
}




class _State extends State<Comments> {
  void dispose() {
comment.dispose();
    super.dispose();
  }
  void initState() {
    super.initState();
    comment.addListener(() {
      setState(() {});
    });
  }
  final comment = TextEditingController();

  double responsiveFontSize(BuildContext context, double scaleFactor) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * scaleFactor;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        primarySwatch: color,
      ),
      home: Scaffold(
       body:SingleChildScrollView(child: Stack(children:[Center(

           child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [SizedBox(height: widget.sizeScreen*0.15,),
         Container(
             width: widget.sizeScreenW,
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
             ),
             child:
             Padding(
                 padding:
                 EdgeInsets.symmetric(horizontal: widget.sizeScreenW*0.05, vertical: widget.sizeScreen*0.03,),child:Text(style: TextStyle(color: Colors.white,fontSize:responsiveFontSize(context, 0.035),   fontWeight: FontWeight.bold, fontFamily: "lato"),textAlign: TextAlign.center,"${widget.nameUser} Ecrivez un commentaire à ${widget.nameC}"))),

             Padding(
       padding:
       EdgeInsets.symmetric(horizontal: widget.sizeScreenW*0.05, vertical: widget.sizeScreen*0.03,),child:Text(comment.text)),
       Lottie.network(
    'https://assets5.lottiefiles.com/packages/lf20_9vqxMBlXUf.json', // chemin vers votre fichier Lottie
    width: widget.sizeScreenW*0.15,
    height: widget.sizeScreen*0.18,
    fit: BoxFit.cover,
    ),
             Padding(
               padding:
               EdgeInsets.symmetric(horizontal: widget.sizeScreenW*0.05, vertical: widget.sizeScreen*0.03),
               child: TextField(

                 autofocus: true,
                 maxLength: 120,
                 controller: comment,
                 decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   hintText: 'Inspirez-vous',
                 ),
               ),
             ),
             Row(mainAxisAlignment: MainAxisAlignment.end, children: [
               TextButton(
                   onPressed: () {


                       comment.clear();
                     Navigator.of(context).pop();
                   },
                   child: Text(style: TextStyle(color: Color(0xFF8D0E57) ),"Annuler")
               ),
               TextButton(
                   onPressed: () {
                     int position2=widget.position;


                     if (comment.text.length > 1) {
                       FirebaseFirestore.instance
                           .collection(
                           'subjets') // Remplacez "collectionName" par le nom de votre collection
                           .doc(widget
                           .idCours) // Remplacez "documentId" par l'ID du document que vous voulez récupérer
                           .collection("topics")
                           .doc(widget.idTopic)
                           .collection("audios")
                           .doc(widget.audio)
                           .collection('comments')
                           .add({
                         'name': widget.nameUser,
                         'description': comment.text,
                         "image":widget.image
                       })
                           .then((value) => {
                         ScaffoldMessenger.of(this.context)
                             .showSnackBar(
                           SnackBar(
                             content: const Text('Le text a été envoyé, cliquez dans le button situez au-dessus de la liste pour recharger les commentaires'),
                             duration: const Duration(seconds: 8),
                           ),
                         ),
Navigator.of(context).pop(),



                     })
                           .catchError((error) => print(
                           "Erreur : $error"));
                     } else {
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           content: const Text(
                             'Il n'+"'"+"y a pas de donnés",),
                           duration: const Duration(seconds: 1),
                         ),
                       );
                     }
                   },
                   child: Text(style: TextStyle(color: Color(0xFF8D0E57) ),"Envoyer")
               ),
             ])
           ]),
         ), Column(
         children: [
           ClipPath(
               clipper: MyClipper(),
               child: CustomAppBar(widget.sizeScreen*0.15,widget.sizeScreenW,this.context))
         ],
       ),])),
    ),);

  }
}
