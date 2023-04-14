import 'package:flesn/screens/SongsPage.dart';
import 'package:flesn/screens/color.dart';
import 'package:flesn/screens/gradient_back.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'Upload.dart';
import 'custom_appbar.dart';
import 'package:custom_clippers/custom_clippers.dart';
List<List<Map>> listaComments = [];
List<Map> lista = [];
List<String> listaId = [];
var codigo2 = "";

class Home extends StatefulWidget {

  Home(this.codigo,  this.name, this.image,this.coursName,this.teacher,this.schedules,this.sizeScreen,this.sizeScreenW,this.userId,{Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

  var codigo = "";
  var name = "";
  var image = "";
  var coursName="";
  var teacher="";
  var schedules="";
  double sizeScreen;
  double sizeScreenW;
  var userId;


}

class _HomeState extends State<Home> {
  Future getData() async {

    lista.clear();
    listaId.clear();
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection("subjets")
        .doc(widget.codigo)
        .collection("topics")
        .get();
    return qn.docs;

  }

  double responsiveFontSize(BuildContext context, double scaleFactor) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * scaleFactor;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: color
      ),
        home: Scaffold(
            body: Stack(
      children: [
        GradientBack("\n\n\n\n\n\n\n                                         ${widget.coursName.toUpperCase()}                                 \n\n\n\n\n Horaires:  ${widget.schedules}\n Enseignant(e):  ${widget.teacher}                              ",widget.sizeScreen,widget.sizeScreenW),
        Positioned.fill(
            top: widget.sizeScreen*0.38,
            left: 0,
            bottom: 0,
            child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  } else if (!snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return Center( child:Column(children: [Lottie.network(
                      'https://assets5.lottiefiles.com/packages/lf20_WpDG3calyJ.json', // chemin vers votre fichier Lottie
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),Text("L'enseingnant(e) n"+"'"+"a pas encore ajouté de sujets", style: TextStyle(fontSize:responsiveFontSize(context, 0.035),color: Colors.black, fontFamily: "lato"),)],));
                  }else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var doc = snapshot.data![index];
                          var data2 = doc.data() as Map;
                          var doc3 = snapshot.data[index].id;


                          return InkWell(
                            onTap: () => {
                            showDialog(context: this.context,barrierDismissible: false, builder: (context)
                            {

                            return Center(child: CircularProgressIndicator());

                            }),
                              FirebaseFirestore.instance
                                  .collection(
                                      'subjets') // Remplacez "collectionName" par le nom de votre collection
                                  .doc(widget
                                      .codigo) // Remplacez "documentId" par l'ID du document que vous voulez récupérer
                                  .collection("topics")
                                  .doc(doc3)
                                  .collection("audios")
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {


                                querySnapshot.docs.forEach((doc) {


                                  lista.add(doc.data() as Map);
                                  listaId.add(doc.id);

                                });
                                String cod=  widget.codigo;
                                String name= widget.name;
                                String image=widget.image;
                                double sizeScreen2=widget.sizeScreen;
                                double sizeScreenW2=widget.sizeScreenW;
                                int position=0;

                                String description=data2["description"];


                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => SongsPage(
                                lista,
                                data2["name"],
                                doc3,
                              cod,
                                listaId,name, image,sizeScreen2,sizeScreenW2, description, position,widget.userId)));

    Navigator.of(this.context, rootNavigator: true).pop();
                              }).catchError((error) => print(
                                      'Erreur lors de la récupération des documents : $error')),

                            },
                            child: ClipPath(
                              clipper: MultipleRoundedPointsClipper(
                                  Sides.bottom,
                                  heightOfPoint: widget.sizeScreen*0.0214),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: widget.sizeScreen*0.0214,
                                  left: widget.sizeScreen*0.0107,
                                  right: widget.sizeScreen*0.0107,
                                ),
                                padding: EdgeInsets.all(widget.sizeScreen*0.0429),
                                color: Color(0XFF7e0c4e),
                                alignment: Alignment.center,
                                child: Text(
                                  data2["name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                      fontSize: widget.sizeScreen*0.01716,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                          );
                        });
                  }
                })),
        Column(
          children: [ClipPath(clipper: MyClipper(), child: CustomAppBar(widget.sizeScreen*0.15,widget.sizeScreenW,this.context))],
        ),
      ],
    )));
  }
}
