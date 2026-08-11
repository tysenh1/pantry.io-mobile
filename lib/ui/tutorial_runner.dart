import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/nav_item.dart';
import 'package:pantry_io_mobile/ui/main_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class TutorialRunner extends StatefulWidget {
  final VoidCallback onComplete;

  const TutorialRunner({super.key, required this.onComplete});

  @override
  State<TutorialRunner> createState() => _TutorialRunnerState();
}

class _TutorialRunnerState extends State<TutorialRunner> {
  late AppDatabase _memoryDb;
  NavTab _tutorialTab = NavTab.addRecipe;

  @override
  void initState() {
    super.initState();
    _memoryDb = AppDatabase.memory();
  }

  @override
  void dispose() {
    _memoryDb.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>.value(
      value: _memoryDb,
      child: ShowCaseWidget(
        builder:  (context) {
            return MainNavigation(
              currentTab: _tutorialTab,
              isLLMConnected: false,
              isTutorial: true,
              onTutorialNextTab: () {
                setState(() {
                  if (_tutorialTab == NavTab.addRecipe) {
                    _tutorialTab = NavTab.receipGetter;
                  }
                  else if (_tutorialTab == NavTab.receipGetter) {
                    _tutorialTab = NavTab.scanner;
                  }
                  else {
                    widget.onComplete();
                  }
                });
              },
              onTabChanged: (tab) {
                setState(() {
                  _tutorialTab = tab;
                });
              },
            );
          }
        )
      );
  }
}