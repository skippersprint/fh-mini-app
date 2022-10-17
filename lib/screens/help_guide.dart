import 'package:flutter/material.dart';

class HelpGuide extends StatelessWidget {
  const HelpGuide({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: RichText(
                text: TextSpan(
                    text: 'Coming soon ',
                    style: themeData.textTheme.bodyMedium,
                    children: [
              WidgetSpan(
                  child: Image.asset(
                    'assets/images/warning.png',
                    width: 15,
                  ),
                  alignment: PlaceholderAlignment.middle)
            ]))),
      ),
    );
  }
}
