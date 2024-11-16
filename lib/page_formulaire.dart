import 'package:flutter/material.dart';

class FormulairePage extends StatefulWidget {
  final Function(String, String, String) onStudentSaved;

  FormulairePage({required this.onStudentSaved});

  @override
  _FormulairePageState createState() => _FormulairePageState();
}

class _FormulairePageState extends State<FormulairePage> {
  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Fonction pour valider et sauvegarder l'étudiant
  void _saveStudent() {
    if (_formKey.currentState!.validate()) {
      // Si la validation réussit, sauvegarde l'étudiant
      widget.onStudentSaved(
        _nomController.text,
        _prenomController.text,
        _emailController.text,
      );
      // Ferme la page et retourne à la liste
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un étudiant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Associe la clé à ce formulaire
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(labelText: 'Nom'),
                // Validation de l'entrée
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
                // Validation de l'entrée
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
                // Validation de l'entrée
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'L\'email ne peut pas être vide';
                  }
                  // Validation pour un email valide
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStudent,
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
