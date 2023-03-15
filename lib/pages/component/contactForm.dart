import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          onFieldSubmitted: (value) {
            name = value;
          },
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Nom de votre organisme',
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        TextFormField(
          onFieldSubmitted: (value) {
            name = value;
          },
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
            hintText: 'Mail de contact',
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            if (!value.contains('@')) {
              return 'Veuillez entrer un Email valide.';
            }
            return null;
          },
        ),
        TextFormField(
          onFieldSubmitted: (value) {
            name = value;
          },
          decoration: const InputDecoration(
            icon: Icon(Icons.phone),
            hintText: 'Numéro de contact',
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            try {
              int.parse(value);
            } catch (e) {
              return 'Veuillez entrer un numéro de telephone valide.';
            }
            return null;
          },
        ),
        ElevatedButton(
          onPressed: () {
            // Validate returns true if the form is valid, or false otherwise.
            if (_formKey.currentState!.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('')),
              );
            }
          },
          child: const Text('Submit'),
        ),
      ]),
    );
  }
}
