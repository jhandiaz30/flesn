import 'package:flesn/main.dart';
import 'package:flesn/screens/Upload.dart';
import 'package:flesn/screens/color.dart';
import 'package:flesn/screens/custom_appbar3.dart';
import 'package:flesn/screens/home.dart';
import 'package:flesn/login.dart';
import 'package:flesn/screens/subjets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Sorbonne Nouvelle",
options: FirebaseOptions(apiKey: "AIzaSyDW6t4FSmMY3yW5jA1H53n4fke0CJis1mM",appId: "1:882887991644:web:d67e1c127b3bd5ce0a6199", messagingSenderId: "882887991644", projectId: "sorbonne-nouvelle")

  );
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
    },
  ));
}



final identifients = TextEditingController();
final motDePasse = TextEditingController();

late String id;
late double size;
late double sizeW;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    identifients.dispose();
    motDePasse.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: color,
        ),
        home: _MyAppState());
  }

}

class _MyAppState extends StatelessWidget {
  var obscureText = true;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(

          builder: (BuildContext context, BoxConstraints constraints) {
            print(constraints.toString());

            size = constraints.maxHeight;
            sizeW = constraints.maxWidth;

            return SingleChildScrollView(child:Stack(children: [

              Column(
                children: [
                  ClipPath(
                      clipper: MyClipper(),
                      child: CustomAppBar3(size * 0.15, sizeW, context))
                ],
              ),

              Container(
                  alignment: Alignment.center,
                  height: constraints.maxHeight *0.40,

                  child: Lottie.network(
                    'https://assets6.lottiefiles.com/packages/lf20_8JmcRVTAyw.json', // chemin vers votre fichier Lottie
                    width: constraints.maxHeight *0.40,
                    height: constraints.maxWidth *0.40,
                    fit: BoxFit.cover,
                  )
              ),
              Center(
                  child: Column(children: [

                    Container(

                      height: constraints.maxHeight / 3,

                    ),
                    Container(
                        height: constraints.maxHeight / 3.toDouble(),
                        width: constraints.maxWidth * 0.90,
                        alignment: Alignment.center,
                        color: color.shade800,
                        child: Container(
                            height: constraints.maxHeight / 3.toDouble() * 0.72,
                            width: constraints.maxWidth * 0.70,
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: sizeW * 0.01,
                                          right: sizeW * 0.01,
                                          top: size * 0.01,
                                          bottom: size * 0),
                                      child: TextField(
                                        autofocus: true,

                                        style: TextStyle(color: color),
                                        controller: identifients,
                                        cursorColor: color,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: size * 0, horizontal: 2),
                                          focusColor: color,
                                          border: OutlineInputBorder(),
                                          hintText: 'Identifiants',
                                        ),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: sizeW * 0.01,
                                          right: sizeW * 0.01,
                                          top: size * 0.01,
                                          bottom: size * 0),
                                      child: TextField(
                                        autofocus: true,

                                        style: TextStyle(color: color),
                                        obscureText: obscureText,
                                        controller: motDePasse,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: size * 0, horizontal: 2),
                                          border: OutlineInputBorder(),
                                          hintText: 'Mot de passe',
                                          fillColor: color,
                                        ),
                                      )),
                                  TextButton(
                                    onPressed: () {
                                      print(identifients.text);
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .where("code", isEqualTo: identifients.text)
                                          .where("password", isEqualTo: motDePasse.text)
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        if (querySnapshot.size == 0) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: const Text('Incorrect'),
                                              duration: const Duration(seconds: 1),
                                            ),
                                          );
                                        } else {
                                          id = querySnapshot.docs[0].id;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Principale(
                                                      querySnapshot.docs[0].id,
                                                      size,
                                                      sizeW,
                                                      querySnapshot.docs[0]["name"])));
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all<Size>(
                                          Size(size * 0.001, size * 0.001)),
                                    ),
                                    child: Text(
                                      "Acceder",
                                      style: TextStyle(fontSize: size * 0.02),
                                    ),
                                  ),
                                ]))),
                    Container(
                      height: constraints.maxHeight / 3,
                    ),
                  ])),

            ]));
          }),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
