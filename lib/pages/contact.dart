import 'package:flutter/material.dart';

import 'component/contactForm.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  var types = [
    'Création de site web',
    'Modification de site web préexistant',
    'Modification de site web préexistant',
    "Création d'application mobile",
    "Création d'application bureau"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: Center(
        child: ContactForm(),
      ),
    );
  }
}
