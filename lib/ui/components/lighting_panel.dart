import 'dart:async';

import 'package:fh_mini_app/ui/components/colors_and_effects.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../utils/widget_functions.dart';
import 'pod_view.dart';
import 'header.dart';
import 'spin_panel.dart';

class LightingPanel extends StatefulWidget {
  const LightingPanel({super.key});

  @override
  State<LightingPanel> createState() => _LightingPanelState();
}

class _LightingPanelState extends State<LightingPanel> {


  Color color = Color.fromARGB(255, 255, 0, 200);
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addVerticalSpace(25),
        Header(),
        addVerticalSpace(25),
        PodView(
          size: size,
          isSpin: spinType,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Color & Effects',
            style: themeData.textTheme.headline4,
          ),
        ),
        ColorsAndEffects(
            hueRingStrokeWidth: 30,
            pickerAreaBorderRadius: BorderRadius.circular(20),
            colorPickerHeight: size.height * 0.15,
            displayThumbColor: false,
            enableAlpha: true,
            pickerColor: color,
            onColorChanged: (color) {
              this.color = color;
            })
      ],
    );
  }
}
