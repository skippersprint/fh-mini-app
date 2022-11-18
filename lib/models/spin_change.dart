import 'package:flutter/widgets.dart';

class SpinChangeModel extends ChangeNotifier {
  int _currentSpin = 1;

  int get currentSpin => _currentSpin;

  set spinChange(int currentSpin) {
    _currentSpin = currentSpin;
    notifyListeners();
  }
}