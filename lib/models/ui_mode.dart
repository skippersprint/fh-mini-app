import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UIModeModel extends ChangeNotifier {

  bool getModeValue = false;

  Future<void> getMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    getModeValue = prefs.getBool('mode') ?? true;
    debugPrint("Got UI Mode : $getModeValue");
  }

  void toggle(bool isOn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('mode', isOn);
    getModeValue = isOn;
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    getModeValue = prefs.getBool('mode') ?? true;
    notifyListeners();
  }
}
