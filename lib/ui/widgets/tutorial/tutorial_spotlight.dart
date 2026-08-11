import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/ui/widgets/tutorial/tutorial_spotlight_card.dart';
import 'package:showcaseview/showcaseview.dart';

class TutorialSpotlight extends StatelessWidget {
  final bool isTutorial;
  final GlobalKey showcaseKey;
  final String title;
  final String description;
  final Widget child;
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onTargetClick;
  final VoidCallback? onSkip;
  final bool disableMovingAnimation;
  final bool showArrow;
  final double overlayOpacity;
  final BorderRadius targetBorderRadius;
  final EdgeInsets targetPadding;

  const TutorialSpotlight({
    super.key,
    required this.isTutorial,
    required this.showcaseKey,
    required this.title,
    required this.description,
    required this.child,
    required this.currentStep,
    required this.totalSteps,
    this.onTargetClick,
    this.onSkip,
    this.disableMovingAnimation = true,
    this.overlayOpacity = 0.75,
    this.showArrow = false,
    this.targetBorderRadius = const BorderRadius.all(Radius.circular(16)),
    this.targetPadding = const EdgeInsets.all(6),
  });

  @override
  Widget build(BuildContext context) {
    if (!isTutorial) return child;

    return Showcase.withWidget(
      key: showcaseKey,
      height: 180,
      width: 280,
      onTargetClick: onTargetClick,
      disposeOnTap: onTargetClick != null ? true : null,
      disableMovingAnimation: disableMovingAnimation,
      overlayOpacity: overlayOpacity,
      targetBorderRadius: targetBorderRadius,
      targetPadding: targetPadding,
      container: TutorialSpotlightCard(
        title: title,
        description: description,
        currentStep: currentStep,
        totalSteps: totalSteps,
        onNext: () {
          ShowCaseWidget.of(context).next();

          if (onTargetClick != null) {
            onTargetClick!();
          }
        },

      ),
      child: child,
    );
  }
}