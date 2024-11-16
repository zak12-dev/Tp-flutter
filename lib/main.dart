import 'package:flutter/material.dart';
import 'page_liste_etudiants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des étudiants',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListeEtudiantsPage(),
    );
  }
}
