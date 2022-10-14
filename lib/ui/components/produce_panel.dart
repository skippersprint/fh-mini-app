import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

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
    final ThemeData themeData = Theme.of(context);
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
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            width: size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Produce Info',
                    style: themeData.textTheme.headline4,
                  ),
                  Center(
                      child: RichText(
                          text: TextSpan(
                              text: 'Section under development ',
                              style: themeData.textTheme.bodyMedium,
                              children: [
                        WidgetSpan(
                            child: Image.asset(
                              'assets/images/warning.png',
                              width: 15,
                            ),
                            alignment: PlaceholderAlignment.middle)
                      ]))),
                  addVerticalSpace(10)
                ]),
          ),
        )
      ],
    );
  }
}
