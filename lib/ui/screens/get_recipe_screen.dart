import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_tag_carousel.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:pantry_io_mobile/ui/widgets/get_recipe_widget.dart';

class GetRecipeScreen extends StatefulWidget {
  const GetRecipeScreen({super.key});

  @override
  State<GetRecipeScreen> createState() => _GetRecipeScreenState();
}

class _GetRecipeScreenState extends State<GetRecipeScreen> {

  bool _areIncompleteRecipesShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: 'Get Recipe'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            AppCard(
              title: 'Filter',
              padding: EdgeInsets.all(4),
              child: Column(
                spacing: 16,
                children: [
                  AppTextField(
                    placeholder: 'Search Recipes',
                  ),
                  AppTagCarousel(tags: ['tag']),
                  SwitchListTile(
                    title: const Text('Show incomplete recipes?'),
                    value: _areIncompleteRecipesShown,
                    onChanged: (bool newValue) {
                      setState(() {
                        _areIncompleteRecipesShown = newValue;
                      });
                    },
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}
