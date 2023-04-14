
import 'package:flesn/screens/Upload.dart';
import 'package:flesn/screens/bienvenue.dart';
import 'package:flesn/screens/home.dart';
import 'package:flesn/screens/subjets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flesn/screens/color.dart';



class Principale extends StatefulWidget {

  Principale(this.id,this.sizeScren,this.sizeScrenW,this.name,{Key? key}) : super(key: key);

late double sizeScren;
  late double sizeScrenW;
  late String id="";
  late String name="";
  @override
  State<Principale> createState() => _MyAppState();
}

class _MyAppState extends State<Principale> {
  late final miVariableDeEstado = widget.id;

  int currentindex=0;

  List miMetodoDentroDelTab(String id) {

    List tabs  = [
      Subjets(id,widget.sizeScren,widget.sizeScrenW),
     Bienvenue(widget.name,widget.sizeScren,widget.sizeScrenW),


    ];
    return tabs;
  }


  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: color,
        ),
        home: Scaffold(

          body:
          miMetodoDentroDelTab(widget.id)[currentindex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentindex,
            items: [
              BottomNavigationBarItem
              (icon: Icon(Icons.school_outlined),
              label: "Cours"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline),
                  label: "Info"
              ),
            ],
            onTap: (index){
              setState(() {
                currentindex=index;
              });

            },
          ),
        )
    );
  }
}



