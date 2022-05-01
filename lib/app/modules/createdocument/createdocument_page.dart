import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto/app/modules/createdocument/createdocument_store.dart';
import 'package:flutter/material.dart';

class CreatedocumentPage extends StatefulWidget {
  final String title;
  const CreatedocumentPage({Key? key, this.title = 'CreatedocumentPage'})
      : super(key: key);
  @override
  CreatedocumentPageState createState() => CreatedocumentPageState();
}

class CreatedocumentPageState extends State<CreatedocumentPage> {
  final CreatedocumentStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 27, 63, 27),
        ),
        body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Atividade",
                      style: GoogleFonts.montserrat(
                        fontSize:30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: title,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Titulo"),
                          focusColor: Colors.black
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: description,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text("Descrição")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: const Text("Criar"),
                        onPressed: () {
                          FirebaseFirestore.instance.collection("todo")
                          .add(
                            {
                            'title': title.text,
                            'description': description.text,
                            'check':false,
                            'data': DateTime.now().toIso8601String(),
                            'uid': FirebaseAuth.instance.currentUser!.uid
                          })
                          .then((value) => Modular.to.pushReplacementNamed('/home'));
                        },
                      ),
                    )
                  ],
                ),
              ),
        );
  }
}
