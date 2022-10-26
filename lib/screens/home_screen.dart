import 'dart:async';

import 'package:fh_mini_app/ui/components/fog_panel.dart';
import 'package:fh_mini_app/ui/components/produce_panel.dart';
import 'package:fh_mini_app/ui/components/spin_panel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/components/lighting_panel.dart';

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

  Future<void> setBNB(int tappedIndex) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('BNB', tappedIndex);
  }

  Future<void> getBNB() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentIndex = prefs.getInt('BNB') ?? 0;
    });
  }  

  void initState() {
    super.initState();
    getBNB();
    triggerManualMode();
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'Fog'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Lights'),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_circle),
            label: 'Spin',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.crop_din), label: 'Produce')
        ],
        currentIndex: _currentIndex,
        onTap: (int tappedIndex) {
          setBNB(tappedIndex);
          setState(() {
            _currentIndex = tappedIndex;
          });
          loadScreen();
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      body: _currentWidget,
    ));
  }
}
