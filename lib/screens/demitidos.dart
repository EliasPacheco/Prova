import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prova_1/screens/edit.dart';

class Demitidos extends StatefulWidget {
  const Demitidos({ Key? key }) : super(key: key);

  @override
  State<Demitidos> createState() => _DemitidosState();
}

class _DemitidosState extends State<Demitidos> {

  final _formKey = GlobalKey<FormState>();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('funcionarios').where('demitido', isEqualTo: true).snapshots();

  CollectionReference ref =
      FirebaseFirestore.instance.collection('funcionarios');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demitidos"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Error! Tente novamente.");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            editNote(docid: snapshot.data!.docs[index]),
                      ),
                    );
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 3,
                            right: 3,
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            title: Text(
                              snapshot.data!.docChanges[index].doc['nome'],
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              snapshot.data!.docChanges[index]
                                  .doc['dataDeContratacao'],
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            trailing: Text(
                              snapshot.data!.docChanges[index].doc['cargo'],
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
        },
      ),
    );
  }
}