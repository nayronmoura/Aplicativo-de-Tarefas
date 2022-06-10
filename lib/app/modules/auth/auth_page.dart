import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto/Assets/paint.dart';
import 'package:projeto/aoth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  final String title;
  const AuthPage({Key? key, this.title = 'AuthPage'}) : super(key: key);
  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  final store = Modular.get<AothService>();
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser==null) {
      return Scaffold(
        backgroundColor:const Color.fromARGB(255, 27, 63, 27) ,
          body: CustomPaint(
            painter: CircularBackgroundPainter(),
            child: Container(
                decoration:const BoxDecoration(
                  image: DecorationImage(image: Svg("lib/Assets/Mobile login.svg")
                  )
                ),
                child: Center(
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(height: 70,),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("LOGIN WITH\n GOOGLE",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSerif(fontSize: 40,fontWeight: FontWeight.bold),
                      )),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.5,),
                      ElevatedButton(
                          onPressed: () async {
                            bool aoth = await store.SignInWithGoogle();
                            if (aoth) {
                              Modular.to.pushReplacementNamed('/home');
                            }
                          },
                          child: const Icon(FontAwesomeIcons.google)),
                    ],
                  ),
                ),
              ),
          ),
      );
    } else {
      Modular.to.pushReplacementNamed('/home');
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
