import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto/aoth_service.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  final String title;
  const TasksPage({Key? key, this.title = 'TasksPage'}) : super(key: key);
  @override
  TasksPageState createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    final store = Modular.get<AothService>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 63, 27),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tarefas",
          style: GoogleFonts.montserrat(fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 62, 143, 65),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => store.signout(),
              child: const Icon(Icons.exit_to_app),
            ),
          ),
        ],
        leading: Center(
          child: GestureDetector(
            onTap: () {
              Modular.to.pushReplacementNamed('/home/account');
            },
            child: CircleAvatar(
              child: Container(
                width: 190.0,
                height: 190.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(FirebaseAuth
                            .instance.currentUser!.photoURL as String))),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: Svg('lib/Assets/background-task.svg'),
                opacity: 0.1,
                scale: 0.1)),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("todo")
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                List<DocumentSnapshot> todo = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: todo.length,
                  itemBuilder: (context, index) {
                    var data = todo[index];
                    return ListTile(
                      title: Text(
                        data['title'],
                        style: GoogleFonts.openSans(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        data['description'],
                        style: GoogleFonts.openSans(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      leading: TextButton(
                        child: const Icon(Icons.check_box),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .doc(data.reference.path)
                              .delete();
                        },
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/home/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FirebaseAuth {}
