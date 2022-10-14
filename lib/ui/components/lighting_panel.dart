import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
        HueRingPicker(
          pickerAreaBorderRadius: BorderRadius.circular(20),
            colorPickerHeight: 160,
            displayThumbColor: false,
            enableAlpha: false,
            pickerColor: color,
            onColorChanged: (color) {
              this.color = color;
            })
      ],
    );
  }

  pickColor(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text('Pick your color'),
            content: Column(
              children: [
                blockColorPicker(),
                TextButton(
                  child: Text('SELECT'),
                  onPressed: (() {
                    debugPrint('$color');
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            )));
  }

  Widget MaterialColorPicker() {
    return MaterialPicker(
      pickerColor: color,
      onColorChanged: (color) => setState(() => this.color = color),
    );
  }

  Widget blockColorPicker() {
    return BlockPicker(
      pickerColor: color,
      onColorChanged: (color) => setState(() => this.color = color),
    );
  }

  Widget packageColorPicker() {
    return HueRingPicker(
      pickerColor: color,
      onColorChanged: (color) => setState(() {
        this.color = color;
      }),
    );
  }
}
