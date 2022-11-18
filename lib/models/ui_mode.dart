import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UIModeModel extends ChangeNotifier {
  bool getModeValue = false;
  Color accent = Color.fromARGB(235, 187, 255, 0);

  Future<void> getMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    getModeValue = prefs.getBool('mode') ?? true;
    debugPrint("Got UI Mode : $accent");
  }

  void toggle(bool isOn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('mode', isOn);
    getModeValue = isOn;
    notifyListeners();
  }

  void changeAccent(Color color) {
    accent = color;
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    getModeValue = prefs.getBool('mode') ?? true;
    notifyListeners();
  }
}
