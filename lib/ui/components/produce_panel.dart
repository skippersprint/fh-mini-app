import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/widget_functions.dart';
import 'pod_view.dart';
import 'header.dart';
import 'spin_panel.dart';

class ProducePanel extends StatefulWidget {
  const ProducePanel({super.key});

  @override
  State<ProducePanel> createState() => _ProducePanelState();
}

class _ProducePanelState extends State<ProducePanel> {
  @override
   Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        addVerticalSpace(25),
        Header(),
        addVerticalSpace(25),
        PodView(
          size: size,
          isSpin: spinType,
        ),
        
      ],
    );
  }
}