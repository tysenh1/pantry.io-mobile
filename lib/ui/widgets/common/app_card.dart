

import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? action;
  final Color? color;
  const AppCard({
    super.key,
    required this.child,
    this.action,
    this.title,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, right: 20, bottom: 24, left: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color ?? Theme.of(context).colorScheme.primaryContainer
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title != null || action != null) ...[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20
                      ),
                    ),
                  if (action != null) action!,
                ],
              ),
            const SizedBox(height: 16)
          ],
          child,
        ]
      )
    );
  }
}