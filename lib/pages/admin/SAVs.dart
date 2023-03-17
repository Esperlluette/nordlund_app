import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SAVs extends StatefulWidget {
  const SAVs({super.key});

  @override
  State<SAVs> createState() => _SAVsState();
}

class _SAVsState extends State<SAVs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des SAV'),
      ),
    );
  }
}
