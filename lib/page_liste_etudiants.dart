import 'package:flutter/material.dart';
import 'page_formulaire.dart';
import 'page_details.dart';

class ListeEtudiantsPage extends StatefulWidget {
  @override
  _ListeEtudiantsPageState createState() => _ListeEtudiantsPageState();
}

class _ListeEtudiantsPageState extends State<ListeEtudiantsPage> {
  List<Map<String, String>> etudiants = [];

  // Fonction pour ajouter un étudiant à la liste
  void _addStudent(String nom, String prenom, String email) {
    setState(() {
      etudiants.add({
        'nom': nom,
        'prenom': prenom,
        'email': email,
      });
    });
  }

  // Fonction pour mettre à jour les informations d'un étudiant
  void _updateStudent(Map<String, String> updatedStudent) {
    setState(() {
      int index = etudiants.indexWhere((etudiant) => etudiant['email'] == updatedStudent['email']);
      if (index != -1) {
        etudiants[index] = updatedStudent;
      }
    });
  }

  // Fonction pour supprimer un étudiant
  void _deleteStudent(Map<String, String> studentToDelete) {
    setState(() {
      etudiants.removeWhere((etudiant) => etudiant['email'] == studentToDelete['email']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des étudiants')),
      body: ListView.builder(
        itemCount: etudiants.length,
        itemBuilder: (context, index) {
          var etudiant = etudiants[index];
          return ListTile(
            title: Text('${etudiant['prenom']} ${etudiant['nom']}'),
            subtitle: Text(etudiant['email']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsEtudiantPage(
                    etudiant: etudiant,
                    onStudentUpdated: _updateStudent,
                    onStudentDeleted: _deleteStudent,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ouvre la page de formulaire pour ajouter un étudiant
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormulairePage(onStudentSaved: _addStudent),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
