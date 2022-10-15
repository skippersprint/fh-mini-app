import 'dart:async';

import 'package:fh_mini_app/ui/components/hue_ring_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  void sendHex(String hexString) async {
    try {
      await get(Uri.parse('http://192.168.4.1/hex?hexCode=${hexString}'));
    } on TimeoutException catch (_) {
      debugPrint('Connection Timeout hex');
    }
  }

  Color color = Color.fromARGB(255, 255, 0, 200);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        addVerticalSpace(25),
        Header(),
        addVerticalSpace(25),
        PodView(
          size: size,
          isSpin: spinType,
        ),
        HueRingPickerM(
            hueRingStrokeWidth: 30,
            pickerAreaBorderRadius: BorderRadius.circular(20),
            colorPickerHeight: 140,
            displayThumbColor: false,
            enableAlpha: true,
            pickerColor: color,
            onColorChanged: (color) {
              this.color = color;
            }),
        TextButton(
          child: Text('Set Color'),
          onPressed: (() {
            String hexString = color.toString();
            debugPrint('$color');
            sendHex(hexString);
          }),
        ),
      ],
    );
  }
}
