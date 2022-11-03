import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/spin_change.dart';
import '../../utils/widget_functions.dart';
import 'pod_view.dart';
import 'header.dart';

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

  int currentSpinState = 0;

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

  var buttonsSelected = [false, true, false];

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
                      splashColor: Color.fromARGB(0, 0, 0, 0),
                      fillColor: Color.fromARGB(0, 0, 0, 0),
                      borderWidth: 0,
                      //unselected icons color
                      color: Color.fromARGB(255, 91, 91, 91),
                      selectedColor: Theme.of(context).colorScheme.secondary,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 6),
                            child: Icon(Icons.rotate_left)),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 6),
                            child: Icon(Icons.sync_disabled)),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 6),
                            child: Icon(Icons.rotate_right)),
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
