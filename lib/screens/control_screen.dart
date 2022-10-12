import 'dart:async';

import 'package:fh_mini_app/utils/constants.dart';
import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

//Parent Control Widget
//On instantiation enables manualMode (life of 2min)
//Consists of the model assets(gif and img) and a bottom navigation bar
//In it resides more stateful widgets - FogControl, RotationControl, NeoControl

class ControlScreen extends StatefulWidget {
   ControlScreen({super.key,});
  String name = 'ankit';
  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  void triggerManualMode() async {
    try {
      Response resp = await get(Uri.parse('http://192.168.4.1/manualMode'))
          .timeout(Duration(seconds: 3));
      debugPrint('In manual mode now (limited)');
    } on TimeoutException catch (_) {
      debugPrint('Connection Timeout');
    }
  }

  bool _isGif = true;
  static bool _lights = false;
  static int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _controlOptions = <Widget>[
    Container(
      color: Color.fromARGB(255, 255, 203, 220),
      child: Text(
        'Neopixel Control',
        style: optionStyle,
      ),
    ),
    FogControl(),
    SpinControl(),
  ];

  void _onItemtapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    triggerManualMode();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              addVerticalSpace(25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'FH-MINI',
                      style: themeData.textTheme.headline3,
                    ),
                    Icon(
                      Icons.account_circle,
                      size: 35,
                    )
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: size.width,
                  child: _isGif
                      ? Image.asset('assets/images/miniHalt.png')
                      : Image.asset('assets/images/miniHalt.png'),
                ),
              ),
              _controlOptions[_selectedIndex]
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb_circle_outlined), label: 'LEDs'),
            BottomNavigationBarItem(
                backgroundColor: Colors.yellow,
                icon: Icon(Icons.water_drop),
                label: 'Fog'),
            BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(Icons.change_circle),
                label: 'Rotation')
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 37, 37, 37),
          onTap: _onItemtapped,
          unselectedItemColor: Color.fromARGB(255, 179, 179, 179),
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}

//Stateful widget that controls fog
//Makes get requests respective to the buttons
//Consists of a toggle bar and a switch

class FogControl extends StatefulWidget {
  @override
  State<FogControl> createState() => _FogControlState();
}

class _FogControlState extends State<FogControl> {
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

  List<bool> isSelected = [false, false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Fog Cycles',
            style: themeData.textTheme.headline4,
          ),
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
        addVerticalSpace(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/glass-of-water.png',
              width: 40,
            ),
            Text('Water level')
          ],
        ),
        addVerticalSpace(30),
        SwitchListTile(
            title: Text(
              'Make it rain',
              style: themeData.textTheme.bodyText2,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 70),
            value: fogState,
            onChanged: (bool value) {
              setState(() {
                fogState = value;
                fogState ? fogFetch(20) : fogFetch(40);
              });
            },
            secondary: Image.asset('assets/images/mist.png')),
      ],
    );
  }
}

class SpinControl extends StatefulWidget {
  @override
  State<SpinControl> createState() => _SpinControlState();
}

class _SpinControlState extends State<SpinControl> {
  static List<bool> buttonsSelected = [true, false, false];

  void getRotation(int index) async {
    try {
      Response response = await get(Uri.parse('http://192.168.4.1/spin/$index'))
          .timeout(Duration(seconds: 3));
      debugPrint('ESP says : $response');
    } on TimeoutException catch (_) {
      debugPrint('Connection Timeout');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Rotational Control', style: themeData.textTheme.headline5),
          ToggleButtons(
              borderRadius: BorderRadius.circular(12),
              fillColor: Color.fromARGB(255, 211, 211, 211),
              color: brandBlack,
              selectedColor: brandWhite,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Image.asset(
                      'assets/images/rotateAnticlockwise.png',
                      width: 32,
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Image.asset(
                      'assets/images/stop-button.png',
                      width: 32,
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Image.asset(
                      'assets/images/rotateClockwise.png',
                      width: 32,
                    )),
              ],
              isSelected: buttonsSelected,
              onPressed: (int index) {
                setState(() {
                  getRotation(index);
                  debugPrint('Fog fetch func called');
                  debugPrint('$index');
                  for (int i = 0; i < buttonsSelected.length; i++) {
                    buttonsSelected[i] = i == index;
                  }
                  ControlScreen();
                });
              })
        ],
      ),
    );
  }
}
