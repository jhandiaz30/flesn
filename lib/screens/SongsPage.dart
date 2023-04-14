import 'package:flesn/main.dart';
import 'package:flesn/screens/Upload.dart';
import 'package:flesn/screens/home.dart';
import 'package:flesn/screens/review_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

import 'color.dart';
import 'comments.dart';
import 'custom_appbar.dart';
import 'gradient_back.dart';

class SongsPage extends StatefulWidget {

  static final _formKey = GlobalKey<FormState>();
var userId;
  List<String> listId;
  String image;
  List<Map> songs;
  String name;
  String nameUser;
  int position = 0;
  var idTopic;
  var idCours;
  double sizeScreen;
  double sizeScreenW;
String description;
  SongsPage(

  this.songs, this.name, this.idTopic, this.idCours, this.listId, this.nameUser, this.image, this.sizeScreen, this.sizeScreenW, this.description, this.position, this.userId);

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  late   Future<List<DocumentSnapshot>>_futureDocument;
  late   Future<List<DocumentSnapshot>>_futureComments;

  late AudioPlayer musicPlayer;

  bool isplaying1 = false;
  bool _isVisible = false;
  bool _isVisibleComments = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _futureDocument = getAudios(widget.idCours, widget.idTopic);

  }

  Future<void> _refreshData() async {
      _futureDocument = getAudios(widget.idCours, widget.idTopic);
    setState(() {}); // Notificar que la pantalla debe actualizarse
  }

  double responsiveFontSize(BuildContext context, double scaleFactor) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * scaleFactor;
  }
  String line (String text, int x, int y, int z){

    if(text.length<y){
return text;
    }
    else {
      String subText = text.substring(x, y);

      int index = subText.lastIndexOf(' ', subText.length);


      text = text.replaceRange(index + x, index + x + 1, '\n');

      if ((index + y) <= text.length) {
        return line(text, index, y + z, z);
      }
      else {
        return text;
      }
    }
  }
  Future<List<DocumentSnapshot>> getComentarios(String id) async {
    CollectionReference comentariosRef = FirebaseFirestore.instance
        .collection(
            'subjets') // Remplacez "collectionName" par le nom de votre collection
        .doc(widget
            .idCours) // Remplacez "documentId" par l'ID du document que vous voulez récupérer
        .collection("topics")
        .doc(widget.idTopic)
        .collection("audios")
        .doc(id)
        .collection('comments');

    QuerySnapshot querySnapshot = await comentariosRef.get();
    return querySnapshot.docs;
  }

  Future<List<DocumentSnapshot>> getAudios(String idCours, String idTopics) async {
    final collectionRef = FirebaseFirestore.instance
        .collection(
        'subjets') // Remplacez "collectionName" par le nom de votre collection
        .doc(idCours) // Remplacez "documentId" par l'ID du document que vous voulez récupérer
        .collection("topics")
        .doc(idTopics).collection("audios");
    final querySnapshot = await collectionRef.get();

    return querySnapshot.docs;
  }







  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    myController.dispose();

    super.dispose();
  }

  // Initializing the Music Player and adding a single [PlaylistItem]
  Future<void> initPlatformState() async {
    musicPlayer = AudioPlayer();
  }
  @override
    void   didUpdateWidget(covariant SongsPage oldWidget) async {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    _futureDocument = getAudios(widget.idCours,widget.idTopic);




  }

  final myController = TextEditingController();

  late String id;
  late String autor;


  @override
  Widget build(BuildContext context) {





    return MaterialApp(
      theme: ThemeData(
        primarySwatch: color,
      ),
      home: Scaffold(


          body:RefreshIndicator(
      onRefresh: _refreshData,
    child: FutureBuilder<List<DocumentSnapshot>>(
      future: _futureDocument,
      builder: (context, snapshot) {

      if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
      }
      else if (snapshot.hasError) {

      return Center(child: Text('Il y'+"'"+'a'+" eu une erreur."));

      }
    else if (!snapshot.hasData ||
    snapshot.data!.isEmpty) {

      return Stack(children:[Center(

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
                  EdgeInsets.symmetric(horizontal: widget.sizeScreenW*0.05, vertical: widget.sizeScreen*0.03,),child:Text(style: TextStyle(color: Colors.white,fontSize:responsiveFontSize(context, 0.035),   fontWeight: FontWeight.bold, fontFamily: "lato"),textAlign: TextAlign.center,"${widget.nameUser}, Soyez la première personne en ajoutant du contenu."))),

          Center( child:Lottie.network(
            'https://assets3.lottiefiles.com/packages/lf20_OgvFROFB4S.json', // chemin vers votre fichier Lottie
            width: widget.sizeScreenW*0.20,
            height: widget.sizeScreen*0.20,
            fit: BoxFit.cover,
          )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [

            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Upload(widget.nameUser, widget.idCours, widget.idTopic, widget.sizeScreen, widget.sizeScreenW, widget.description, widget.userId)));


                },
                child: Text( style: TextStyle(color: Color(0xFF8D0E57),fontSize:responsiveFontSize(context, 0.035)),"Ajouter")
            ),
          ])

        ]),
      ), Column(
        children: [
          ClipPath(
              clipper: MyClipper(),
              child: CustomAppBar(widget.sizeScreen*0.15,widget.sizeScreenW,this.context))
        ],
      ),]);

      }
      return Stack(children: [

        Visibility(visible: _isVisibleComments , child: ListView(children: [
          GradientBack(widget.description,widget.sizeScreen,widget.sizeScreenW),
        Center(
            child: Column(
          children: [
            SizedBox(
              height: widget.sizeScreen*0.09,
            ),

            Stack(
              children: [

                Center(
                  child: Card(
                    child: Container(
                      height: widget.sizeScreen*0.25,
                      width: widget.sizeScreenW*0.80,
                      child: Image.network(
                        snapshot.data![widget.position]["image_url"],
                        height:  widget.sizeScreen*0.25,
                        width: widget.sizeScreenW*0.80,
                          fit: BoxFit.cover
                      ),
                    ),
                    elevation: 10,
                  ),
                ),
                Container(
                  height: widget.sizeScreen*0.25,
                  alignment: Alignment.topRight,

                      child: TextButton(
                    onPressed: () {
                      setState(() {});

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Upload(widget.nameUser, widget.idCours, widget.idTopic, widget.sizeScreen, widget.sizeScreenW, widget.description,widget.userId)));
                    },
                    child: Icon(
                      Icons.music_note,
                      color: Color(0xFF8D0E57),
                      size: widget.sizeScreen*0.07,
                    ),
                  ),
                ),
                Container(
                  height:  widget.sizeScreen*0.30,
                  width: widget.sizeScreenW,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [


                          TextButton(
                        onPressed: () {
                          setState(() {
                            isplaying1 = false;
                          });
                          musicPlayer.stop();
                        },
                        child: Icon(
                          Icons.play_disabled,
                          size: widget.sizeScreen*0.07,
                          color: isplaying1 == true
                              ? Colors.black
                              : Color(0xFF8D0E57),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isplaying1 = true;
                          });
                          musicPlayer.setUrl(snapshot.data![widget.position]["url"]);
                          musicPlayer.play();
                        },
                        child: Icon(
                          Icons.play_circle,
                          size: widget.sizeScreen*0.07,
                          color: isplaying1 == true
                              ? Color(0xFF8D0E57)
                              : Colors.black,
                        ),
                      ),
                       TextButton(
                        onPressed: () {
                          musicPlayer.stop();

                          setState(() {
                            isplaying1 = true;
                            isplaying1 = false;
                          });
                          musicPlayer.setUrl(snapshot.data![widget.position]["url"]);
                          widget.position++;

                          if (widget.position == snapshot.data!.length) {
                            widget.position = 0;
                          }
                        },
                        child: Icon(
                          Icons.skip_next_sharp,
                          size: widget.sizeScreen*0.07,
                          color: isplaying1 == true
                              ? Color(0xFF8D0E57)
                              : Colors.black,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),

            Column(
              children: [
                SizedBox(
                  height: widget.sizeScreen*0.05,
                  width: 100,
                ),
                Container(
                  width: widget.sizeScreenW,
                    decoration:BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF8D0E57),
                        Color(0XFF7e0c4e),
                      ],
                      begin: FractionalOffset(0.2, 0.0),
                      end: FractionalOffset(1.0, 0.6),
                      stops: [0.0, 0.6],
                      tileMode: TileMode.clamp,

                    )
                ),
                    child:
                Text(
                    style: TextStyle(color: Colors.white,fontSize:responsiveFontSize(context, 0.035),   fontWeight: FontWeight.bold, fontFamily: "lato" ),
                    textAlign: TextAlign.center,

                    "${widget.position+1}. Vous êtes dans le sujet  ${widget.name},\n enregistrement de ${snapshot.data![widget.position]["autor"]}")),


                TextButton(onPressed: _refreshData,
                    child: Icon( size: widget.sizeScreen*0.05,
                     Icons.refresh))
                
                ,Stack(children:[

                     Container(
                        width: widget.sizeScreenW,

                        margin: EdgeInsets.only(
                          left: sizeW*0.0,
                          right: sizeW*0.0,
                        ),
                        alignment: Alignment.center,
                        height: widget.sizeScreen*0.30,

                        child: FutureBuilder<List<DocumentSnapshot>>(
                          future:  getComentarios(snapshot.data![widget.position].id),
                          builder: (context, snapshot) {


                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Column(children: [Lottie.network(
                                'https://assets5.lottiefiles.com/packages/lf20_WpDG3calyJ.json', // chemin vers votre fichier Lottie
                                width: size*0.40,
                                height: sizeW*0.20,
                                fit: BoxFit.cover,
                              ),Text("il n"+"'"+"y pas de commentaires", style: TextStyle(fontSize:responsiveFontSize(context, 0.035),color: Colors.black))],);
                            } else {
                              List<DocumentSnapshot> comentarios = snapshot.data!;
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> data = comentarios[index]
                                      .data() as Map<String, dynamic>;


                                  print(snapshot.data!.length);

                                  // Aquí puedes mostrar los datos en el formato que desees
                                  return ReviewList(
                                      data["image"], data["name"], line(data["description"], 0,30,30), widget.sizeScreen, widget.sizeScreenW);
                                },
                              );
                            }
                          },
                        )),   Container(width:widget.sizeScreenW*0.95,
                      height: widget.sizeScreen*0.35,
                      alignment: Alignment.bottomRight,child: FloatingActionButton(
                    onPressed: () {
                      String id=snapshot.data![widget.position].id;
                      String autor=snapshot.data![widget.position]["autor"];


                      int position2=widget.position;
                      print(lista);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Comments(widget.name,widget.idTopic,widget.idCours,widget.nameUser,widget.image,widget.sizeScreen,widget.sizeScreenW,id,autor, widget.description, position2
                              )));

                    },
                    backgroundColor:Color(0xFF8D0E57),
                    child: const Icon(Icons.comment_sharp),))]),


                SizedBox(
                  height: widget.sizeScreen*0.02,
                  width: 100,
                ),
              ],
            ),

          ],
        ))])),

        Column(
          children: [ClipPath(clipper: MyClipper(), child: CustomAppBar(widget.sizeScreen*0.15,widget.sizeScreenW,this.context))],
        ),
      ]);}),
    )));
  }
}
