import 'package:flutter/material.dart';

import '../../utils/widget_functions.dart';

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
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 25, top: 10),
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
