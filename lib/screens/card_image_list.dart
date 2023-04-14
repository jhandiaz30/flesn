import 'package:flesn/screens/home.dart';
import 'package:flutter/material.dart';
import 'card_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class CardImageList extends StatefulWidget {

   CardImageList(this.usuarioId,this.sizeScreen,this.sizeScreenW,{Key? key}) : super(key: key);
   late List<Map>lista=[];
   late List<Map>listaid=[];
   late double sizeScreen;
   late double sizeScreenW;
   String usuarioId;
  @override
  State<CardImageList> createState() => _CardImageList();

}

class _CardImageList extends State<CardImageList>{



  late List<DocumentSnapshot<Object?>> myDocuments = [];

  final CollectionReference usuariosRef = FirebaseFirestore.instance.collection('users');

   @override
  Widget build(BuildContext context) {
    // TODO: implement build

     return FutureBuilder<DocumentSnapshot>(
       future: usuariosRef.doc(widget.usuarioId).get(),
       builder: (context, snapshot) {
         if (snapshot.connectionState == ConnectionState.done) {
           if (snapshot.hasError) {
             return Text('Error al obtener datos del usuario');
           } else {
             final List<dynamic> cursosRef = snapshot.data!["courses"];
             final String name = snapshot.data!["name"];
             final String image = snapshot.data!["image"];
             final List<Future<DocumentSnapshot>> cursosSnapshotsFutures = [];
             for (final cursoRef in cursosRef) {
               cursosSnapshotsFutures.add(cursoRef.get());
             }
             return FutureBuilder<List<DocumentSnapshot>>(
               future: Future.wait(cursosSnapshotsFutures),
               builder: (context, snapshot) {
                 if (snapshot.connectionState == ConnectionState.done) {
                   if (snapshot.hasError) {
                     return Text('Error al obtener datos de cursos');
                   } else {
                     final List<DocumentSnapshot> cursosSnapshots = snapshot.data!;
                     return ListView.builder(
                       itemCount: cursosSnapshots.length,
                       itemBuilder: (context, index) {
                         final Map<String, dynamic> cursoData = cursosSnapshots[index].data() as Map<String, dynamic>;
                          return InkWell(
                           onTap: ()=>Navigator.push(context,
                               MaterialPageRoute(builder: (context)=>Home(
                                   cursosSnapshots[index].id,name,image,cursosSnapshots[index]["name"] ,cursosSnapshots[index]["teacher"],cursosSnapshots[index]["schedule"]
, widget.sizeScreen, widget.sizeScreenW,widget.usuarioId
                               ))),
                           child:Container(
                             height: widget.sizeScreen*0.60,
                             child: ListView(
                               padding: EdgeInsets.all(widget.sizeScreen*0.0268),
                               scrollDirection: Axis.horizontal,
                               children: [
                                 CardImage(cursoData["image"],widget.sizeScreen,widget.sizeScreenW),

                               ],
                             ),
                           ),
                         );
                       },
                     );
                   }
                 } else {
                   return CircularProgressIndicator();
                 }
               },
             );
           }
         } else {
           return CircularProgressIndicator();
         }
       },
     );
  }

}