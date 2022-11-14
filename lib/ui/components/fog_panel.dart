import 'dart:async';

import 'package:fh_mini_app/config/custom_theme.dart';
import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FogPanel extends StatefulWidget {
  const FogPanel({super.key});

  @override
  State<FogPanel> createState() => _FogPanelState();
}

class _FogPanelState extends State<FogPanel> {
  bool fogState = false;
  double _value = 0.0;

  void fogFetch(int index) async {
    String url = 'http://192.168.0.103/fog/$index';
    debugPrint(url);

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
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fog Cycles',
                    style: themeData.textTheme.headline4,
                  ),
                  addVerticalSpace(30),
                  Text('Current fog rate : ${_value.toInt() * 5} %'),
                  Container(
                      child: Slider(
                    divisions: 10,
                    label: '${_value.toInt()} min',
                    activeColor: Theme.of(context).primaryColor,
                    thumbColor: Theme.of(context).colorScheme.secondary,
                    min: 0,
                    max: 20,
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                    onChangeEnd: (value) {
                      setState(() {
                        debugPrint('Value ends here : ${value.toInt()}');
                        fogFetch(value.toInt());
                      });
                    },
                  )),
                  SwitchListTile(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(
                        'Make it rain',
                        style: themeData.textTheme.bodyText2,
                      ),
                      //contentPadding: EdgeInsets.symmetric(horizontal: 70),
                      value: fogState,
                      onChanged: (bool value) {
                        setState(() {
                          fogState = value;
                          fogState ? fogFetch(1) : fogFetch(11);
                        });
                      },
                      secondary: fogState
                          ? Image.asset(
                              'assets/images/rainyOn.png',
                              width: 30,
                            )
                          : Image.asset(
                              'assets/images/rainy.png',
                              width: 30,
                            )),
                  addVerticalSpace(20)
                ]),
          ),
        )
      ],
    );
  }
}
