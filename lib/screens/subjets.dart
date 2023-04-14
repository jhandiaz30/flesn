import 'package:flutter/material.dart';
import 'custom_appbar2.dart';
import 'description_place.dart';
import 'view.dart';
import 'review_list.dart';
import 'gradient_back.dart';
import 'package:flutter/services.dart';
import 'header_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flesn/screens/card_image_list.dart';



class Subjets extends StatefulWidget {
  Subjets(this.id,this.sizeScreen,this.sizeScreenW,{Key? key}) : super(key: key);

  String id;
  double sizeScreen;
  double sizeScreenW;

  State<Subjets> createState() => _Subjets();
}

class _Subjets extends State<Subjets> {

  late List<Map>list=[];
  late List<Map>listId;
  Future getData() async{

    QuerySnapshot qn = await FirebaseFirestore.instance.collection("users").get();
    return qn.docs;

  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool _enChargement = true;

    @override
    void initState() {
      super.initState();

      // Attendre 3 secondes avant de cacher le CircularProgressIndicator
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _enChargement = false;
        });
      });
    }


    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot){

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if(snapshot.connectionState== ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),

          );
        }


        if (snapshot.connectionState == ConnectionState.done) {



          return
            Stack(
              children: [
                GradientBack("Listes de cours",widget.sizeScreen,widget.sizeScreen),

                CardImageList(widget.id, widget.sizeScreen,widget.sizeScreenW),
                Column( children:
                [ClipPath(
                    clipper: MyClipper(),
                    child: CustomAppBar2(widget.sizeScreen*0.15,widget.sizeScreenW,this.context))],
                ),
              ],
            );
        }

        return Text("loading");
      },
    );
    /*

*/


  }

}
