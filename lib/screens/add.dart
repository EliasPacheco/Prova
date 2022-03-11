import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prova_1/screens/demitidos.dart';
import 'package:prova_1/screens/edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final nomeKey = GlobalKey<FormFieldState>();
  final cargoKey = GlobalKey<FormFieldState>();
  final setorKey = GlobalKey<FormFieldState>();
  final dnKey = GlobalKey<FormFieldState>();
  final dcKey = GlobalKey<FormFieldState>();

  TextEditingController nome = TextEditingController();
  TextEditingController cargo = TextEditingController();
  TextEditingController setor = TextEditingController();
  TextEditingController dn = TextEditingController();
  TextEditingController dc = TextEditingController();
  TextEditingController dd = TextEditingController();
  TextEditingController demitido = TextEditingController();

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('funcionarios')
      .where('demitido', isEqualTo: false)
      .snapshots();
//Todos
//FirebaseFirestore.instance.collection('funcionarios').snapshots();
//Demitidos
//FirebaseFirestore.instance.collection('funcionarios').where('demitido', isEqualTo: true).snapshots();
//Admitidos
//FirebaseFirestore.instance.collection('funcionarios').where('demitido', isEqualTo: false).snapshots();
  CollectionReference ref =
      FirebaseFirestore.instance.collection('funcionarios');

  var maskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        title: const Text("Funcionários"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Demitidos()),
                );
              },
              icon: const Icon(Icons.dangerous_sharp))
        ],
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
          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Padding(
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
                  data["nome"],
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  data["dataDeContratacao"],
                  style: const TextStyle(fontSize: 15),
                ),
                trailing: Text(
                  data["cargo"],
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => editNote(
                                docid: document,
                              )));
                },
              ),
            );
          }).toList());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Adicionar funcionário"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        TextFormField(
                          key: nomeKey,
                          controller: nome,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Nome e Sobrenome",
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          validator: (name) {
                            if (name!.isEmpty) {
                              return "Campo Obrigatório";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          key: cargoKey,
                          controller: cargo,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Cargo",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Campo Obrigatório";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          key: setorKey,
                          controller: setor,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Setor",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Campo Obrigatório";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          key: dnKey,
                          controller: dn,
                          inputFormatters: [maskFormatter],
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Data de nascimento",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Campo Obrigatório";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          key: dcKey,
                          controller: dc,
                          inputFormatters: [maskFormatter],
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Data de contratação",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Campo Obrigatório";
                            }
                          },
                        ),
                        TextFormField(
                          controller: dd,
                          inputFormatters: [maskFormatter],
                          keyboardType: TextInputType.number,
                          enabled: false,
                        ),
                        TextFormField(
                          controller: demitido,
                          inputFormatters: [maskFormatter],
                          keyboardType: TextInputType.number,
                          enabled: false,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    // ignore: deprecated_member_use
                    FlatButton(
                      // ignore: sort_child_properties_last
                      child: const Text(
                        "Voltar",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () async {
                        nomeKey.currentState!.validate() ||
                            cargoKey.currentState!.validate() ||
                            setorKey.currentState!.validate() ||
                            dnKey.currentState!.validate() ||
                            dcKey.currentState!.validate();

                        await ref.add({
                          'nome': nome.text,
                          'cargo': cargo.text,
                          "setor": setor.text,
                          "dataDeNascimento": dn.text,
                          "dataDeContratacao": dc.text,
                          "dataDoDesligamento": dd.text,
                          "demitido": dd.text.isNotEmpty,
                        }).whenComplete(() {
                          Navigator.of(context).pop();
                        });
                        nomeKey.currentState!.reset();
                        cargoKey.currentState!.reset();
                        setorKey.currentState!.reset();
                        dnKey.currentState!.reset();
                        dcKey.currentState!.reset();
                      },
                      child: const Text(
                        "Salvar",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
