import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prova_1/screens/add.dart';

class editNote extends StatefulWidget {
  DocumentSnapshot docid;
  editNote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState();
}

class _editnoteState extends State<editNote> {
  TextEditingController nome = TextEditingController();
  TextEditingController cargo = TextEditingController();
  TextEditingController setor = TextEditingController();
  TextEditingController dn = TextEditingController();
  TextEditingController dc = TextEditingController();
  TextEditingController dd = TextEditingController();
  TextEditingController demitir = TextEditingController();


  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var maskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
  );

  @override
  void initState() {
    nome = TextEditingController(text: widget.docid.get('nome'));
    cargo = TextEditingController(text: widget.docid.get('cargo'));
    setor = TextEditingController(text: widget.docid.get('setor'));
    dn = TextEditingController(text: widget.docid.get('dataDeNascimento'));
    dc = TextEditingController(text: widget.docid.get('dataDeContratacao'));
    dd = TextEditingController(text: widget.docid.get('dataDoDesligamento'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Editar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: TextFormField(
              controller: nome,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                hintText: "Nome",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: TextFormField(
              controller: cargo,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                hintText: "Cargo",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: TextFormField(
              controller: setor,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                hintText: "Setor",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: TextFormField(
              inputFormatters: [maskFormatter],
              controller: dn,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                hintText: "Data de nascimento",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: TextFormField(
              controller: dc,
              inputFormatters: [maskFormatter],
              keyboardType: TextInputType.number,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                hintText: "Data de contratação",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: TextFormField(
              controller: dd,
              inputFormatters: [maskFormatter],
              keyboardType: TextInputType.number,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                hintText: "Data do desligamento",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 15,
                      shadowColor: Colors.blueAccent),
                  child: const Text(
                    'Demitir',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    widget.docid.reference.update({
                      'demitido': true ,
                      "dataDoDesligamento": dd.text,
                    }).whenComplete(() {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      elevation: 15,
                      shadowColor: Colors.blueAccent),
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Excluir"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  const Text(
                                      "Deseja excluir este funcionário?")
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              // ignore: deprecated_member_use
                              FlatButton(
                                // ignore: sort_child_properties_last
                                child: const Text(
                                  "Não",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              // ignore: deprecated_member_use
                              FlatButton(
                                onPressed: () {
                                  widget.docid.reference
                                      .delete()
                                      .whenComplete(() {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const Text(
                                  "Sim",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 15,
                      shadowColor: Colors.blueAccent),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    widget.docid.reference.update({
                      'nome': nome.text,
                      'cargo': cargo.text,
                      "setor": setor.text,
                      "dataDeNascimento": dn.text,
                      "dataDeContratacao": dc.text,
                      "dataDoDesligamento": dd.text,
                      'demitido': dd.text.isNotEmpty,
                    }).whenComplete(() {
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
