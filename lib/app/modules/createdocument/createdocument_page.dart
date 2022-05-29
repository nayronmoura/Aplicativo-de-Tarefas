import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  Color selectedColor = Colors.green;

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
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: title,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Titulo"),
                  focusColor: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: description,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Descrição")),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: AlertDialog(
                          title: const Text("Selecione uma Cor"),
                          content: ColorPicker(
                            pickerColor: selectedColor,
                            onColorChanged: (Color cor) {
                                selectedColor = cor;
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              child: const Text('Selecionado'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      color: selectedColor,
                      width: 30,
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 3, 0, 3),
                      child: Text("Selecione uma cor para a atividade"),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: title.text.length > 1
                      ? () => pushFirebase(title, description)
                      : null,
                  child: const Text("Criar")),
            )
          ],
        ),
      ),
    );
  }

  void changeColor(Color cor) {}

  void pushFirebase(
      TextEditingController title, TextEditingController description) {
    FirebaseFirestore.instance.collection("todo").add({
      'title': title.text,
      'description': description.text,
      'data': DateTime.now().toIso8601String(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'color': selectedColor.value
    }).then((value) => Modular.to.pushReplacementNamed('/home'));
  }
}
