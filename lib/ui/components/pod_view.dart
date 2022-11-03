import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/spin_change.dart';
import '../../models/ui_mode.dart';

class PodView extends StatelessWidget {
  const PodView({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final bool uiTheme = Provider.of<UIModeModel>(context).isDarkMode;
    final int providerSpinType =
        Provider.of<SpinChangeModel>(context).currentSpin;
    return SizedBox(
        height: size.height * 0.38, child: podAsset(uiTheme, providerSpinType));
  }

  Widget podAsset(bool uiTheme, int spinType) {
    if (uiTheme) {
      return spinType == 1
          ? Image.asset('assets/images/${spinType}_dark.png')
          : Image.asset('assets/images/${spinType}_dark.gif');
    } else {
      return spinType == 1
          ? Image.asset('assets/images/$spinType.png')
          : Image.asset('assets/images/$spinType.gif');
    }
  }
}
