import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:medi_flow/utils/assets_path.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetsPath.logoPng);
  }
}
