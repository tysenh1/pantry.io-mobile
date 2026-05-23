import 'package:flutter/material.dart';

enum NavTab {
  addRecipe,
  chatbot,
  scanner,
  settings,
  debug,
  receipGetter,
}

class NavItem {
  final NavTab id;
  final Widget screen;
  final BottomNavigationBarItem item;
  final bool showIf;

  NavItem({
    required this.id,
    required this.screen,
    required this.item,
    this.showIf = true,
  });
}
