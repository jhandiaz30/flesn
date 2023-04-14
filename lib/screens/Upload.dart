

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flesn/main.dart';
import 'package:flesn/screens/gradient_back2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:lottie/lottie.dart';


import '../login.dart';
import 'color.dart';
import 'custom_appbar.dart';
import 'gradient_back.dart';

class Upload extends StatefulWidget {
   Upload(this.name,this.idCours, this.idTopic,this.sizeScreen,this.sizeScreenW,this.description, this.id,{Key? key}) : super(key: key);
   var id;
   var name;
var idCours;

var idTopic;
String description;

double sizeScreen;
double sizeScreenW;


  @override
  State<Upload> createState() => _UploadState();

}

class _UploadState extends State<Upload> {
  late AudioPlayer musicPlayer;
  int position=0;
  bool isplaying1 = false;
  bool _isVisible = false;


  @override
  void initState() {

    super.initState();
    initPlatformState();

  }


  // Initializing the Music Player and adding a single [PlaylistItem]
  Future<void> initPlatformState() async {

    musicPlayer = AudioPlayer();

  }
  bool _isLoading = false;
  bool _isVisibleButoon = true;
  bool _isVisibleButoon2 = false;
  bool _isVisibleButoon3 = false;
  bool _isVisibleButoon4 = true;


  late String imagePath, songPath;

  late Reference ref;
  var url= "https://firebasestorage.googleapis.com/v0/b/sorbonne-nouvelle.appspot.com/o/animal-ge09162e7d_1280.jpg?alt=media&token=8408e4a0-5e75-415d-86c7-41295836b5a8";
  var url2= "https://firebasestorage.googleapis.com/v0/b/sorbonne-nouvelle.appspot.com/o/animal-ge09162e7d_1280.jpg?alt=media&token=8408e4a0-5e75-415d-86c7-41295836b5a8";
  var song_down_url;
  final fireStoreInstance=FirebaseFirestore.instance;


  void selectImage() async{

    final  image= await FilePicker.platform.pickFiles(type: FileType.custom,

        allowMultiple: false,
        allowedExtensions: ['jpg',
          "jpeg",
          "png",
          "bmp",
          "webp",
          "gif",
          "ico"]);
    if (image != null) {
final x= image.files.single.path.toString();
        final file = File(x);
        imagePath = basename(x);
        uploadPic(file, imagePath);

    }
  }
  double responsiveFontSize(BuildContext context, double scaleFactor) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * scaleFactor;
  }

  void selectSong(BuildContext context) async{

  final  song=await  FilePicker.platform.pickFiles(type: FileType.custom,
        allowedExtensions: ['mp3',
            "m4a",
            "wav",
            "aac",
            "flac",
            "ogg",
            "dsd",
          "opus",
            "aiff"]);
    if (song != null) {
      final x= song.files.single.path.toString();
      final file = File(x);
        songPath=basename(x);
        uploadSong(file, songPath);

    }



  }




  uploadFirebase(){
    musicPlayer.stop();

    showDialog(context: this.context,barrierDismissible: false, builder: (context)
    {

      return   Center(child: Lottie.asset(
        'assets/loading2.json', // chemin vers votre fichier Lottie
        width: 200,
        height:50 ,
        fit: BoxFit.cover,
      ));

    });
    var data={

      "autor":widget.name,
      "url": song_down_url.toString(),
      "image_url":url.toString(),

    };

    ScaffoldMessenger.of(this.context)
        .showSnackBar(
      SnackBar(
        content: const Text("Le contenu a été bien télétransmis, allez jusqu"+"'"+"à la fin"),
        duration: const Duration(seconds: 5),
      ),
    );
        fireStoreInstance.collection("subjets").doc(widget.idCours).collection("topics").doc(widget.idTopic).collection("audios").doc().set(data).then((value) => {



            Navigator.of(this.context, rootNavigator: true).pop(),
          Navigator.of(this.context).pop(),



  }
        );


  }

  Future deleteImg() async{
    showDialog(context: this.context,barrierDismissible: false, builder: (context)
    {

      return Center(child: Lottie.asset(
        'assets/delete.json', // chemin vers votre fichier Lottie
        width: 200,
        height:50 ,
        fit: BoxFit.cover,
      ));

    });
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.refFromURL(url);
    ref.delete().then((_) =>     {   setState(() {
    _isVisibleButoon = !_isVisibleButoon;
    _isVisibleButoon2 = !_isVisibleButoon2;
    url=url2;
    _isVisible = !_isVisible;

    }),   Navigator.of(this.context, rootNavigator: true).pop(),print("eliminado")}
    );


  }

  Future deleteSong() async{
    musicPlayer.stop();
    showDialog(context: this.context,barrierDismissible: false, builder: (context)
    {

      return Center(child: Lottie.asset(
        'assets/delete.json', // chemin vers votre fichier Lottie
        width: 200,
        height:50 ,
        fit: BoxFit.cover,
      ));

    });
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.refFromURL(song_down_url);
    ref.delete().then((_) =>     {    setState(() {
    _isVisibleButoon3 = !_isVisibleButoon3;
    _isVisibleButoon4 = !_isVisibleButoon4;

    }),   Navigator.of(this.context, rootNavigator: true).pop()}

    );


  }
 Future uploadSong(File song,String sng) async {


   showDialog(context: this.context,barrierDismissible: false, builder: (context)
       {

      return Center(child: Lottie.asset(
        'assets/loading2.json', // chemin vers votre fichier Lottie
        width: 200,
        height:50 ,
        fit: BoxFit.cover,
      ));

    });
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref().child(sng);
    UploadTask uploadTask = ref.putFile(song);
    setState(() {
    uploadTask.whenComplete(() async {

      song_down_url = await ref.getDownloadURL().whenComplete(() => {
        setState(() {
          _isVisibleButoon3 = !_isVisibleButoon3;
          _isVisibleButoon4 = !_isVisibleButoon4;

          print(song_down_url);
          Navigator.of(this.context, rootNavigator: true).pop();


        })
      }

      );

    }).catchError((onError) { print(onError); });
    print(song_down_url);

    });
  }
int i=0;
  Future uploadPic(File image,String img) async {
    i++;

    showDialog(context: this.context,barrierDismissible: false, builder: (context){
      return Center(child: Container(child:Lottie.asset(
        'assets/loading2.json', // chemin vers votre fichier Lottie
        width: 200,
        height:50 ,
        fit: BoxFit.cover,
      )));
});

    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref().child(img);
    UploadTask uploadTask = ref.putFile(image);
setState(() {

      uploadTask.whenComplete(() async {

        url = await ref.getDownloadURL().whenComplete(() => {
          setState(() {
        _isVisibleButoon = !_isVisibleButoon;
            _isVisibleButoon2 = !_isVisibleButoon2;

        _isVisible = !_isVisible;



        Navigator.of(this.context, rootNavigator: true).pop();

          })

        });

      }).catchError((onError) { print(onError); });

    });

  }


  @override
  Widget build(BuildContext context) {
    return    MaterialApp(
theme: ThemeData(
  primaryColor: color,
),

      home: Scaffold(

      body:Stack(

children: [GradientBack(widget.description,widget.sizeScreen,widget.sizeScreenW),

      Center(
      child:   Column(
        children: [
          SizedBox(
            height: widget.sizeScreen*0.40
            ,
          ),
          Text(
              style: TextStyle(color: Colors.black,fontSize:responsiveFontSize(context, 0.035),   fontWeight: FontWeight.bold, fontFamily: "lato" ),
              textAlign: TextAlign.center,
              "Espace dédié pour la télétransmision des enregistrements et des images. "),

         Row( mainAxisAlignment: MainAxisAlignment.end ,children: [
            Visibility(
                visible: _isVisibleButoon2,
                child:Row(
                    children:[
                      TextButton(

                        onPressed: deleteImg,
                        child: Icon(
                          Icons.image_not_supported,
                          size:  widget.sizeScreen*0.05,
                          color:  Color(0xFF8D0E57),
                        ),
                      )])),

            Visibility(
                visible: _isVisibleButoon3,
                child:Center(child:Row( children:[

                  TextButton(

                    onPressed: deleteSong,
                    child: Icon(
                      Icons.music_off,
                      size:  widget.sizeScreen*0.05,
                      color:   Color(0xFF8D0E57),

                    ),
                  )]))),

            Visibility(
                visible: _isVisibleButoon,
                child: Row( mainAxisAlignment: MainAxisAlignment.center,children: [

                  TextButton(

                    onPressed: selectImage,
                    child: Icon(
                      Icons.image,
                      size:  widget.sizeScreen*0.05,
                      color:  Color(0xFF8D0E57),

                    ),
                  )])),
            Visibility(
                visible: _isVisibleButoon4,
                child: Row( mainAxisAlignment: MainAxisAlignment.center,children: [

                  TextButton(

                    onPressed: () async{
                       selectSong(context);
                    },
                    child: Icon(
                      Icons.music_note,
                      size:  widget.sizeScreen*0.05,
                      color:   Color(0xFF8D0E57),

                    ),
                  )])),
          ]
          ),
          Stack(children:[
            Center(child:
          Card(


            child:   Container(
                height: widget.sizeScreen*0.25,
                width: widget.sizeScreenW*0.80,
              child: Visibility(
                visible: _isVisible,
                child:
              Image.network(
                url,   height:  widget.sizeScreen*0.25,
                width: widget.sizeScreenW*0.80,
                  fit: BoxFit.cover

              ),
              )
            ),
            elevation: 10,
          )),Visibility(visible: _isVisibleButoon3,
                child: Container(
                  height:  widget.sizeScreen*0.30,
                  width: widget.sizeScreenW*0.90,              alignment: Alignment.bottomCenter,
              child:
              Row(
                children: [
                  SizedBox(

                    width: 100,

                  ),
                  Expanded(
                      child: TextButton(

                        onPressed: () {
                          setState(() {
                            isplaying1=false;
                          });
                          musicPlayer.stop();
                        },
                        child: Icon(
                          Icons.play_disabled,
                          size: widget.sizeScreen*0.07,
                          color: isplaying1==true ? Colors.black : Color(0xFF8D0E57),

                        ),
                      )),
                  Expanded(

                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isplaying1=true;
                          });
                          musicPlayer.setUrl(song_down_url);
                          musicPlayer.play();

                        },
                        child: Icon(
                          Icons.play_circle,
                          size: widget.sizeScreen*0.07,
                          color: isplaying1==true ? Color(0xFF8D0E57) : Colors.black,
                        ),
                      )),

                  Expanded(

                      child: TextButton(

                        onPressed: () {

                          musicPlayer.stop();
                          setState(() {
                            isplaying1=true;
                            isplaying1=false;
                          });
                          musicPlayer.setUrl(song_down_url);


                        },
                        child: Icon(
                          Icons.play_arrow,
                          size: widget.sizeScreen*0.07,
                          color: isplaying1==true ? Color(0xFF8D0E57) : Colors.black,

                        ),
                      )),
                  SizedBox(
                    height: 0
                    ,
                    width: (widget.sizeScreenW*0.25),

                  ),
                ],
              ),)) ]),
          SizedBox(
            height: 0
            ,
            width: 0,

          ),



Visibility(visible: _isVisibleButoon2 ==true && _isVisibleButoon3 ==true ? true :false,
    child:
          TextButton(
              onPressed: uploadFirebase,
              child: Text(style: TextStyle(
                fontSize: responsiveFontSize(context, 0.035),
                color: Color(0xFF8D0E57)
              ),
             "Envoyer"
              ),)),

          Visibility(visible: _isVisibleButoon2 ==false && _isVisibleButoon3 ==false ? true :false,child:  Container(alignment: Alignment.center,child:Lottie.asset(
            'assets/upload.json', // chemin vers votre fichier Lottie
            width: widget.sizeScreenW*0.533,
            height:widget.sizeScreen*0.1874 ,
            fit: BoxFit.cover,
          )))
        ],
      ),
    ),
  Column( children:
  [ClipPath(
      clipper: MyClipper(),
      child: CustomAppBar(widget.sizeScreen*0.15,widget.sizeScreenW,context))],
  ),
]
    )
    )
    );

  }
}
