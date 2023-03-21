import 'package:flutter/material.dart';

import '../../component/clients/ClientSelector.dart';

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  Widget? _body;

  @override
  void initState() {
    super.initState();
    _body = ClientSelector();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Clients'),
      ),
      body: _body,
    );
  }
}
