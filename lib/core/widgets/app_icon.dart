/// Company: CETAM
/// Project: QParking
/// File: app_icon.dart
/// Created on: 30/11/2025
/// Created by: Carlos Adair Bautista Godinez
/// Approved by: Daniel Yair Mendoza Alvarez
library;

import 'package:flutter/material.dart';
import '../icons/app_icons.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.name,
    this.size,
    this.color,
    this.semanticLabel,
    this.excludeFromSemantics = true,
});

  final AppIconName name;
  final double? size;
  final Color? color;
  final String? semanticLabel;
  final bool excludeFromSemantics;

  @override
  Widget build(BuildContext context) {
    final iconData = kAppIconMap[name];
    assert(iconData != null, 'Icon data not found for $name');

    final icon = Icon(iconData, size: size, color: color);

    if (excludeFromSemantics) {
      return ExcludeSemantics(child: icon);
    }
    return Semantics(label: semanticLabel,child: icon);
  }
}