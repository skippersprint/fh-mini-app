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

  Future<void> setMode(bool isOn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('mode', isOn);
    getModeValue = isOn;
    notifyListeners();
  }

  Future<void> setAccent(Color color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String accentColor = color.toString();
    debugPrint(accentColor);
    prefs.setString('accent', accentColor);
    accent = color;
    notifyListeners();
  }

  Future<void> getAccent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String colorString = (prefs.getString('accent') ?? 'Color(0xb059ff00)');
    String valueString = colorString.split('(0x')[1].split(')')[0]; // hacky..
    int value = int.parse(valueString, radix: 16);
    accent = Color(value);
    debugPrint("Got color : $accent");
  }

  Future<void> initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    getModeValue = prefs.getBool('mode') ?? true;
    getAccent();
    notifyListeners();
  }
}
