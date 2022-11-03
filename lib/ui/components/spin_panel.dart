import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/spin_change.dart';
import '../../utils/widget_functions.dart';

class SpinPanel extends StatefulWidget {
  const SpinPanel({super.key});

  @override
  State<SpinPanel> createState() => _SpinPanelState();
}

class _SpinPanelState extends State<SpinPanel> {
  void makeGetReq(int index) async {
    try {
      Response response = await get(Uri.parse('http://192.168.4.1/spin/$index'))
          .timeout(Duration(seconds: 3));
      debugPrint(response.body);
    } on TimeoutException catch (_) {
      debugPrint('Connection timeout');
    }
  }

  int currentSpinState = 2;

  Future<void> setSpinState(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('spinState', index);
    debugPrint("Hogaya set baliye ${prefs.getInt('spinState')}");
  }

  Future<void> getSpinState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentSpinState = prefs.getInt('spinState') ?? 1;
    debugPrint('Value got from spin Cache - $currentSpinState');
    //setState required because, changing BAB index causes SpinPanel to rerun
    //hence requires currentSpinState value again
    setState(() {
      for (int i = 0; i < buttonsSelected.length; i++) {
        buttonsSelected[i] = i == currentSpinState;
      }
    });
  }

  var buttonsSelected = [false, false, true];

  @override
  void initState() {
    super.initState();
    getSpinState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 25, top: 10),
            width: size.width,
            //color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Spin it up!',
                  style: themeData.textTheme.headline4,
                ),
                Center(
                  child: ToggleButtons(
                      children: [
                        CustomIcon(
                            icon: const Icon(Icons.rotate_left),
                            isSelected: buttonsSelected[0]),
                        CustomIcon(
                            icon: const Icon(Icons.sync_disabled),
                            isSelected: buttonsSelected[1]),
                        CustomIcon(
                            icon: const Icon(Icons.rotate_right),
                            isSelected: buttonsSelected[2]),
                      ],
                      isSelected: buttonsSelected,
                      onPressed: (int index) {
                        setState(() {
                          currentSpinState = index;
                          makeGetReq(index);
                          debugPrint('Fog fetch func called');
                          Provider.of<SpinChangeModel>(context, listen: false)
                              .spinChange = index;
                          //spinType = index;
                          setSpinState(index);
                          debugPrint('Pod spinning in $index');
                          for (int i = 0; i < buttonsSelected.length; i++) {
                            buttonsSelected[i] = i == index;
                          }
                        });
                      }),
                ),
                addVerticalSpace(10)
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CustomIcon extends StatelessWidget {
  final Icon? icon;
  final bool isSelected;
  final double? height;

  const CustomIcon({Key? key, this.icon, this.isSelected = false, this.height = 47})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        border: isSelected
            ? Border.all(
                color: const Color(0xffC5CAE9),
              )
            : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Center(
        child: Container(
          child: icon,
        ),
      ),
    );
  }
}
