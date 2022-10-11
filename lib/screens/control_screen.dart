import 'package:fh_mini_app/utils/constants.dart';
import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
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
    Container(
      color: Color.fromARGB(255, 255, 223, 233),
      child: Text(
        'Rotation Control',
        style: optionStyle,
      ),
    ),
  ];

  void _onItemtapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

class FogControl extends StatefulWidget {
  @override
  State<FogControl> createState() => _FogControlState();
}

class _FogControlState extends State<FogControl> {
  bool _lights = false;
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
            value: _lights,
            onChanged: (bool value) {
              setState(() {
                _lights = value;
              });
            },
            secondary: Image.asset('assets/images/mist.png')),
      ],
    );
  }
}

class FogCycles extends StatelessWidget {
  const FogCycles({super.key, required this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 8, 8, 8).withAlpha(25)),
      margin: const EdgeInsets.only(left: 25),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text!,
        style: themeData.textTheme.headline5,
      ),
    );
  }
}
