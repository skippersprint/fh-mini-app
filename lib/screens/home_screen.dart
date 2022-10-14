import 'dart:async';

import 'package:fh_mini_app/ui/components/fog_panel.dart';
import 'package:fh_mini_app/ui/components/produce_panel.dart';
import 'package:fh_mini_app/ui/components/spin_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

import '../ui/components/fog_panel.dart';
import '../ui/components/lighting_panel.dart';
import '../ui/components/spin_panel.dart';
import '../ui/components/lighting_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void triggerManualMode() async {
    try {
      Response resp = await get(Uri.parse('http://192.168.4.1/manualMode'))
          .timeout(Duration(seconds: 3));
      debugPrint('In manual mode now (limited)');
    } on TimeoutException catch (_) {
      debugPrint('Connection Timeout');
    } finally {
      debugPrint('Manual mode ends');
    }
  }

  void initState() {
    super.initState();
    triggerManualMode();
  }

  int _currentIndex = 0;
  String _pageTitle = "home";
  Widget _currentWidget = LightingPanel();

  void loadScreen() {
    switch (_currentIndex) {
      case 0:
        return setState(() {
          _pageTitle = 'LightingDash';
          _currentWidget = LightingPanel();
        });
      case 1:
        return setState(() {
          _pageTitle = 'FogPanel';
          _currentWidget = FogPanel();
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
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Lights'),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'Fog'),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_circle),
            label: 'Spin',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.crop_din), label: 'Produce')
        ],
        currentIndex: _currentIndex,
        onTap: (int tappedIndex) {
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
