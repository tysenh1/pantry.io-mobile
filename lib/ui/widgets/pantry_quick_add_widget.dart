import 'package:flutter/material.dart';

class PantryQuickAddWidget extends StatefulWidget {
  const PantryQuickAddWidget({super.key});

  @override
  State<PantryQuickAddWidget> createState() => _PantryQuickAddWidgetState();
}

class _PantryQuickAddWidgetState extends State<PantryQuickAddWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pantry Stuff")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [Text("Stuff goes here")]),
      ),
    );
  }
}
