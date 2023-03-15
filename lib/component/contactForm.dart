import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nordlund_dev/utils/api/Api.dart';
import 'package:select_form_field/select_form_field.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _phone, _mail, _description;
  var _selected = '1';

  var types = [
    'Création de site web',
    'Modification de site web préexistant',
    'Modification de site web préexistant',
    "Création d'application mobile",
    "Création d'application bureau"
  ];

  Widget buildSelector() {
    List<Map<String, dynamic>> items = createItems();
    return SelectFormField(
      type: SelectFormFieldType.dropdown,
      icon: const Icon(Icons.arrow_downward_sharp),
      items: items,
      onChanged: (value) {
        _selected = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          onSaved: (value) {
            _name = value;
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
          onSaved: (value) {
            _mail = value;
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
          onSaved: (value) {
            _phone = value;
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
        buildSelector(),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Description',
          ),
          maxLines: 7,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onSaved: (value) {
            _description = value;
          },
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if (kDebugMode) {
                print(
                    ' _Name: $_name \n Mail: $_mail, \n Phone: $_phone \n Selected value : $_selected \n description : $_description');
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Envoie du formulaire, vous allez être redirigé.'),
                    duration: Duration(seconds: 2)),
              );
              inspect(Api.postContact(
                  _name as String,
                  _mail as String,
                  _phone as String,
                  _description as String,
                  _selected));
            }
          },
          child: const Text('Submit'),
        ),
      ]),
    );
  }

  List<Map<String, dynamic>> createItems() {
    List<Map<String, dynamic>> list = [];
    int i = 1;
    for (var type in types) {
      Map<String, dynamic> map = {'value': i, 'label': type};
      i++;
      list.add(map);
    }

    return list;
  }
}
