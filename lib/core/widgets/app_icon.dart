/// Company: CETAM
/// Project: QParking
/// File: app_icon.dart
/// Created on: 13/12/2025
/// Created by: Rodrigo Peña
/// Approved by: Gamaliel Juarez
///
/// Changelog:
/// - ID: 2 | Modified on: 13/12/2025 | Rodrigo Peña | Added SizedBox and Center to fix alignment issues (Problem #2).
library;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../icons/app_icons.dart';
import '../theme/app_theme.dart';

/// A widget that renders an icon based on its [AppIconName] alias.
class AppIcon extends StatelessWidget {
  final AppIconName name;
  final double? size;
  final Color? color;

  const AppIcon({
    super.key,
    required this.name,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final iconData = kAppIconMap[name] ?? FontAwesomeIcons.circleQuestion;
    // Default size standard 24px
    final finalSize = size ?? 24.0;

    // FIX: Wrap in SizedBox + Center to mimic Material Icon behavior
    // This ensures icons are perfectly centered inside buttons or containers
    return SizedBox(
      width: finalSize,
      height: finalSize,
      child: Center(
        child: FaIcon(
          iconData,
          size: finalSize,
          // Note: FontAwesome icons sometimes look larger than Material icons at the same px.
          // If they still look too big, you can slightly reduce this: size: finalSize * 0.9
          color: color ?? AppTheme.primary,
        ),
      ),
    );
  }
}