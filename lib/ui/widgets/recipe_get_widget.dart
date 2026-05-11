import 'package:flutter/material.dart';

class RecipeGetWidget extends StatefulWidget {
  const RecipeGetWidget({super.key});

  @override
  State<RecipeGetWidget> createState() => _RecipeGetWidgetState();
}

class _RecipeGetWidgetState extends State<RecipeGetWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search For Recipes")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [Text("Stuff goes here")]),
      ),
    );
  }
}
