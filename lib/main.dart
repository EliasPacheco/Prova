import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prova_1/screens/add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Prova",
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}