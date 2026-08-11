
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';

class TutorialSpotlightCard extends StatelessWidget {
  final String title;
  final String description;
  final int currentStep;
  final int totalSteps;
  final VoidCallback onNext;

  const TutorialSpotlightCard({
    super.key,
    required this.title,
    required this.description,
    required this.currentStep,
    required this.totalSteps,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 8)
          )
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            // color: Theme.of(context).colorScheme.p
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                    Text(
                      '$currentStep of $totalSteps',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant
                      )
                    )
                  ]
                ),
              ]
            )
          ),

          Flexible(
            // child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium
                  )
                ]
              )
            // )
          )
          // header goes here
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       title,
          //       style: theme.textTheme.titleMedium?.copyWith(
          //         fontWeight: FontWeight.bold,
          //       )
          //     ),
          //     Text(
          //       '$currentStep of $totalSteps',
          //       style: theme.textTheme.labelSmall?.copyWith(
          //         color: theme.colorScheme.onSurfaceVariant,
          //       )
          //     ),
          //     const SizedBox(height: 8),
          //
          //     Text(
          //       description,
          //       style: theme.textTheme.bodyMedium?.copyWith(
          //         color: theme.colorScheme.onSurfaceVariant
          //       )
          //     ),
          //
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         TextButton(
          //           onPressed: onSkip,
          //           style: TextButton.styleFrom(
          //             foregroundColor: theme.colorScheme.onSurfaceVariant,
          //             padding: EdgeInsets.zero,
          //             minimumSize: Size.zero,
          //             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //           ),
          //           child: const Text('Skip tutorial'),
          //         ),
          //         FilledButton.tonal(
          //           onPressed: onNext,
          //           style: FilledButton.styleFrom(
          //             visualDensity: VisualDensity.compact,
          //           ),
          //           child: Text(currentStep == totalSteps ? 'Done' : 'Next'),
          //         ),
          //       ],
          //     ),
          //   ]
          // )
        ]
      )
    );
  }
}