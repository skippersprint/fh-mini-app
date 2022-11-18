import 'dart:async';

import 'package:fh_mini_app/models/ui_mode.dart';
import 'package:fh_mini_app/services/auth.dart';
import 'package:fh_mini_app/ui/components/colors_and_effects.dart';
import 'package:fh_mini_app/ui/components/fog_panel.dart';
import 'package:fh_mini_app/ui/components/produce_panel.dart';
import 'package:fh_mini_app/ui/components/spin_panel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/spin_change.dart';
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
  bool _controlMode = false;

  void controlMode(bool mode) async {
    //mode ? 1 : 0;

    String url = 'http://192.168.4.1/mode/$mode';
    debugPrint(url);
    try {
      Response fogResponse =
          await get(Uri.parse(url)).timeout(Duration(seconds: 3));
      print('Response from ESP : ${fogResponse.body}');
    } on TimeoutException catch (_) {
      print('Could not communicate');
    }
  }

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

  //get and set bottom app bar index.

  Future<void> setBAB(int tappedIndex) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('BNB', tappedIndex);
  }

  Future<void> getBAB() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentIndex = prefs.getInt('BNB') ?? 0;
    //load control mode with _currentIndex picked from SharedPreferences
    loadScreen();
    //set toggle button based on _currentIndex
    //setstate not required as this _currentIndex is to be known only once
    //in the app life
    for (int i = 0; i < buttonsSelected.length; i++) {
      buttonsSelected[i] = i == _currentIndex;
    }
  }

  @override
  void initState() {
    super.initState();
    getBAB();

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
    final uiTheme = Provider.of<UIModeModel>(context, listen: false);
    final AuthService auth = AuthService();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            //actions: [Icon(Icons.settings)],
            elevation: 0.0,
          ),
          drawer: Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      foregroundImage: AssetImage("assets/images/dp.png"),
                    ),
                    accountName: Text(
                      'Ankit',
                    ),
                    accountEmail: Text('ajangid663@fmail.com')),
                // ListTile(
                //   title: const Text('Profile'),
                //   leading: Icon(Icons.account_circle),
                //   onTap: null,
                // ),
                // ListTile(
                //   title: const Text('Insights'),
                //   leading: Icon(Icons.insights),
                //   onTap: null,
                // ),
                //Accent tile only available in dark mode.

                ListTile(
                    title: const Text('Dark Mode'),
                    leading: Icon(Icons.nightlight),
                    trailing: Switch(
                      value: uiTheme.getModeValue,
                      onChanged: (value) {
                        uiTheme.toggle(value);
                      },
                      activeColor: Theme.of(context).colorScheme.secondary,
                    )),
                uiTheme.getModeValue
                    ? ListTile(
                        title: const Text('Accent'),
                        leading: Icon(
                          Icons.palette,
                        ),
                        onTap: () {
                          //switch to lighting panel
                          setState(() {
                            _currentIndex = 1;
                            debugPrint('Index 1 activated');
                            setBAB(1);
                            loadScreen();
                            for (int i = 0; i < buttonsSelected.length; i++) {
                              buttonsSelected[i] = i == 1;
                            }
                          });
                          Navigator.pop(context);
                          accentInstruction(context);
                        },
                      )
                    : SizedBox.shrink(),
                ListTile(
                  title: const Text('Log out'),
                  leading: Icon(Icons.logout),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    auth.signOut();
                  },
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                          onTap: (() => Navigator.pop(context)),
                          child: SizedBox(
                            height: 60,
                            child: ListTile(
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
            //color: Color.fromARGB(255, 31, 31, 31),
            shape: const CircularNotchedRectangle(),
            elevation: 20,
            //notchMargin: 6.0,
            child: Container(
              height: 60.0,
              child: ToggleButtons(
                  renderBorder: false,
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
                      setBAB(index);
                      loadScreen();
                      for (int i = 0; i < buttonsSelected.length; i++) {
                        buttonsSelected[i] = i == index;
                      }
                    });
                  }),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(

              //mini: true,
              child: Icon(
                _controlMode ? Icons.bolt : Icons.sports_esports, //bolt
              ),
              onPressed: () {
                setState(() {
                  _controlMode = !_controlMode;
                  controlMode(_controlMode);
                  debugPrint('Control mode toggled');
                });
              }),
          body: ChangeNotifierProvider(
            create: (context) => SpinChangeModel(),
            child: Column(
              children: [
                addVerticalSpace(25),
                Center(child: PodView(size: size)),
                Expanded(child: _currentWidget),
              ],
            ),
          )),
    );
  }
}

Future<dynamic> accentInstruction(BuildContext context) {
  final uiTheme = Provider.of<UIModeModel>(context, listen: false);
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
              'The current color on the color wheel will be set as accent.'),
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: currentHsvColor.toColor(),
                ),
                onPressed: () {
                  uiTheme.changeAccent(currentHsvColor.toColor());
                  Navigator.pop(context);
                },
                child: Text('Okay'))
          ],
        );
      });
}
