import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_chip.dart';

class AppTagCarousel extends StatelessWidget {
  // This may need to change depending on how I want to use tags
  final Set<String> tags;
  final AppChipMode mode;
  final ValueChanged<String>? onSelect;
  final ValueChanged<String>? onRemoved;
  final Set<String>? selectedTags;
  final Alignment? alignment;

  const AppTagCarousel({
    super.key,
    required this.tags,
    this.mode = AppChipMode.display,
    this.onSelect,
    this.onRemoved,
    this.selectedTags,
    this.alignment = Alignment.center
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: alignment,
      height: 32,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,

            children: tags.map((tag) {
              final isSelected = selectedTags?.contains(tag) ?? false;

              return switch (mode) {
                AppChipMode.display => AppChip(
                  label: tag,
                  mode: mode,
                ),

                AppChipMode.selectable => AppChip(
                  label: tag,
                  mode: mode,
                  onSelect: () {
                    if (onSelect != null) onSelect!(tag);
                  },
                  isSelected: isSelected,
                ),

                AppChipMode.removable => AppChip(
                  label: tag,
                  mode: mode,
                  onRemoved: () {
                    if (onRemoved != null) onRemoved!(tag);
                  },
                )
              };
            }).toList()
          )
        )
      )
    );
  }
}