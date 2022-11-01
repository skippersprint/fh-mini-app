import 'dart:async';

import 'package:fh_mini_app/ui/components/fog_panel.dart';
import 'package:fh_mini_app/ui/components/produce_panel.dart';
import 'package:fh_mini_app/ui/components/spin_panel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/components/lighting_panel.dart';
import '../ui/components/pod_view.dart';
import '../utils/widget_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void triggerManualMode() async {
    try {
      Response resp = await get(Uri.parse('http://192.168.4.1/manualMode'))
          .timeout(Duration(seconds: 30));
      debugPrint('In manual mode now (limited)');
    } on TimeoutException catch (_) {
      debugPrint('Connection Timeout');
    } finally {
      debugPrint('Manual mode ends');
    }
  }

  //get and set bottom navigation index number.

  Future<void> setBNB(int tappedIndex) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('BNB', tappedIndex);
  }

  Future<void> getBNB() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentIndex = prefs.getInt('BNB') ?? 0;
      //load control mode with _currentIndex picked from SharedPreferences
      loadScreen();
      //set toggle button based on _currentIndex
      for (int i = 0; i < buttonsSelected.length; i++) {
        buttonsSelected[i] = i == _currentIndex;
      }
    });
  }

  void initState() {
    super.initState();
    getBNB();

    //triggerManualMode();
  }

  String _pageTitle = "home";
  Widget _currentWidget = FogPanel();

  void loadScreen() {
    switch (_currentIndex) {
      case 0:
        return setState(() {
          _pageTitle = 'FogPanel';
          _currentWidget = FogPanel();
        });
      case 1:
        return setState(() {
          _pageTitle = 'LightingDash';
          _currentWidget = LightingPanel();
        });
      case 2:
        return setState(() {
          _pageTitle = 'SpinPanel';
          _currentWidget = SpinPanel();
        });
      case 3:
        return setState(() {
          _pageTitle = 'ProducePanel';
          _currentWidget = ProducePanel();
        });
    }
  }

  var buttonsSelected = [false, true, false, false];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Mini'),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  foregroundImage: AssetImage("assets/images/dp.png"),
                ),
                accountName: Text('Ankit'),
                accountEmail: Text('ajangid663@fmail.com')),
            ListTile(
              title: const Text('Profile'),
              leading: Icon(Icons.account_circle),
              trailing: Icon(Icons.arrow_forward),
              onTap: null,
            ),
            ListTile(
              title: const Text('Insights'),
              leading: Icon(Icons.insights),
              trailing: Icon(Icons.arrow_forward),
              onTap: null,
            ),
            ListTile(
              title: const Text('Appearance'),
              leading: Icon(Icons.smartphone),
              trailing: Icon(Icons.arrow_forward),
              onTap: null,
            ),
            ListTile(
              title: const Text('Settings'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.arrow_forward),
              onTap: null,
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                      onTap: (() => Navigator.pop(context)),
                      child: SizedBox(
                        height: 60,
                        child: ListTile(
                            tileColor: Color.fromARGB(255, 66, 66, 66),
                            title: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                      ))),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 31, 31, 31),
        shape: const CircularNotchedRectangle(),
        //notchMargin: 6.0,
        child: Container(
          height: 60.0,
          child: ToggleButtons(
              renderBorder: false,
              splashColor: Color.fromARGB(0, 0, 0, 0),
              fillColor: Color.fromARGB(0, 0, 0, 0),
              color: Color.fromARGB(255, 128, 128, 128),
              selectedColor: Theme.of(context).colorScheme.secondary,
              constraints: BoxConstraints.expand(width: size.width / 4),
              children: [
                Icon(
                  Icons.water_drop,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.lightbulb),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Icon(Icons.change_circle),
                ),
                Icon(Icons.paid_rounded),
              ],
              isSelected: buttonsSelected,
              onPressed: (int index) {
                setState(() {
                  _currentIndex = index;
                  debugPrint('Index $index activated');
                  setBNB(index);
                  loadScreen();
                  for (int i = 0; i < buttonsSelected.length; i++) {
                    buttonsSelected[i] = i == index;
                  }
                });
              }),
        ),
       
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          //mini: true,
          child: Icon(
            Icons.sports_esports, //bolt
            color: Color.fromARGB(255, 255, 0, 212),
          ),
          onPressed: () {}),
      body: Column(
        children: [
          addVerticalSpace(25),
          Center(
            child: PodView(
              size: size,
              isSpin: spinType,
            ),
          ),
          Expanded(child: _currentWidget),
        ],
      ),
    ));
  }
}

class BottomIcon extends StatelessWidget {
  final String? iconText;
  final IconData icon;
  final EdgeInsetsGeometry? padding;

  BottomIcon({super.key, this.iconText, required this.icon, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Column(children: [
        InkWell(
          splashColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: () {},
          child: IconButton(
            onPressed: null,
            padding: EdgeInsets.all(0),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        // Text(
        //   iconText,
        //   style: TextStyle(fontSize: 10, color: Colors.white),
        // )
      ]),
    );
  }
}
