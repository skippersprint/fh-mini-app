import 'dart:async';

import 'package:fh_mini_app/ui/components/pod_view.dart';
import 'package:fh_mini_app/ui/components/header.dart';
import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import '../../utils/constants.dart';
import 'spin_panel.dart';

class FogPanel extends StatefulWidget {
  const FogPanel({super.key});

  @override
  State<FogPanel> createState() => _FogPanelState();
}

class _FogPanelState extends State<FogPanel> {
  bool fogState = false;

  void fogFetch(int index) async {
    String url = 'http://192.168.4.1/$index';

    try {
      Response fogResponse =
          await get(Uri.parse(url)).timeout(Duration(seconds: 3));
      print('Response from ESP : ${fogResponse.body}');
    } on TimeoutException catch (_) {
      print('Could not communicate');
    }
  }

  List<bool> isSelected = [true, false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
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
        Text(
          'Fog Cycles',
          style: themeData.textTheme.headline4,
        ),
        addVerticalSpace(30),
        Container(
          margin: EdgeInsets.only(left: 25),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: ToggleButtons(
                borderRadius: BorderRadius.circular(12),
                fillColor: brandBlack,
                color: brandBlack,
                selectedColor: brandWhite,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text('10 s'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text('4 min'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text('8 min'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text('10 min'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text('12 min'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text('14 min'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text('16 min'),
                  ),
                ],
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    fogFetch(index);
                    debugPrint('Fog fetch func called');
                    debugPrint('$index');
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                  });
                }),
          ),
        ),
        addVerticalSpace(50),
       
        SwitchListTile(
            title: Text(
              'Make it rain',
              style: themeData.textTheme.bodyText2,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 90),
            value: fogState,
            onChanged: (bool value) {
              setState(() {
                fogState = value;
                fogState ? fogFetch(20) : fogFetch(40);
              });
            },
            secondary: Image.asset(
              'assets/images/rainy.png',
              width: 30,
            )),
      ],
    );
  }
}