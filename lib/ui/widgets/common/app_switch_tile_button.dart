import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSwitchTileButton extends StatelessWidget {
  final String? label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final EdgeInsetsGeometry padding;

  const AppSwitchTileButton({
    super.key,
    this.label,
    required this.value,
    required this.onChanged,
    this.padding = const EdgeInsets.all(8)
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (label != null)
              Expanded(
                child: Text(
                  label!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Inter',
                    fontSize: 16
                  ),
                ),
              ),
            const SizedBox(width: 16),
            Switch(
              value: value,
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeThumbColor: Theme.of(context).colorScheme.primary,
            )
          ]
        )
      )
    );
  }
}