import 'package:flutter/material.dart';

class ExpandedElevatedButton extends StatelessWidget {
  const ExpandedElevatedButton({
    Key? key,
    required this.label,
    this.onTap,
    this.icon,
  }) : super(key: key);

  ExpandedElevatedButton.inProgress({
    required String label,
    Key? key,
  }) : this(
          label: label,
          icon: Transform.scale(
            scale: 0.5,
            child: const CircularProgressIndicator(),
          ),
          key: key,
        );

  static const double _elevatedButtonHeight = 48;

  final VoidCallback? onTap;
  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    return SizedBox(
      height: _elevatedButtonHeight,
      width: double.infinity,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onTap,
              icon: icon,
              label: Text(
                label,
              ),
            )
          : ElevatedButton(
              onPressed: onTap,
              child: Text(
                label,
              ),
            ),
    );
  }
}
