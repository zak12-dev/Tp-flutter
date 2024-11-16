import 'package:flutter/material.dart';

class DetailsEtudiantPage extends StatefulWidget {
  final Map<String, String> etudiant;
  final Function(Map<String, String>) onStudentUpdated;
  final Function(Map<String, String>) onStudentDeleted;

  DetailsEtudiantPage({
    required this.etudiant,
    required this.onStudentUpdated,
    required this.onStudentDeleted,
  });

  @override
  _DetailsEtudiantPageState createState() => _DetailsEtudiantPageState();
}

class _DetailsEtudiantPageState extends State<DetailsEtudiantPage> {
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _emailController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.etudiant['nom']);
    _prenomController = TextEditingController(text: widget.etudiant['prenom']);
    _emailController = TextEditingController(text: widget.etudiant['email']);
  }

  void _updateStudent() {
    if (_formKey.currentState!.validate()) {
      // Si la validation réussit, met à jour les informations de l'étudiant
      Map<String, String> updatedStudent = {
        'nom': _nomController.text,
        'prenom': _prenomController.text,
        'email': _emailController.text,
      };

      widget.onStudentUpdated(updatedStudent);
      Navigator.pop(context);
    }
  }

  void _deleteStudent() {
    widget.onStudentDeleted(widget.etudiant);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Détails de l\'étudiant')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le nom ne peut pas être vide';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _prenomController,
                decoration: InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le prénom ne peut pas être vide';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'L\'email ne peut pas être vide';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateStudent,
                child: Text('Modifier'),
              ),
              ElevatedButton(
                onPressed: _deleteStudent,
                child: Text('Supprimer'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
