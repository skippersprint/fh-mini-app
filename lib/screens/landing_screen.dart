import 'dart:async';
import 'dart:io';

import 'package:fh_mini_app/screens/control_screen.dart';
import 'package:fh_mini_app/screens/help_guide.dart';
import 'package:fh_mini_app/utils/constants.dart';
import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final url = 'http://192.168.4.1/LED';
  bool? hasLoaded = false;

  void fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    try {
      await get(Uri.parse(url)).timeout(const Duration(seconds: 1));
      if (mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ControlScreen(),
            ));
      }
    } on TimeoutException catch (_) {
      debugPrint("Connection timeout");
      setState(() {
        connectionTimeout(context);
      });
    } on SocketException catch (_) {
      debugPrint("Other exception occured");
    } finally {
      hasLoaded = true;
    }
  }

  @override
  void initState() {
    super.initState();
    print('init state function ran');
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/leaf.jpg',
              height: size.height,
              fit: BoxFit.fitHeight,
            ),
            Center(
              child: Column(
                children: [
                  addVerticalSpace(50),
                  Image.asset(
                    'assets/images/logo.png',
                    height: size.height * 0.14,
                  ),
                  Text(
                    'Welcome to the future of food',
                    style: themeData.textTheme.headline4,
                  ),
                  addVerticalSpace(30),
                  Text(
                    'Connecting to your pod',
                    style: themeData.textTheme.bodySmall,
                  ),
                  addVerticalSpace(10),
                  spinkit(hasLoaded),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget spinkit(hasLoaded) {
    return hasLoaded
        ? const SizedBox.shrink()
        : const SpinKitWanderingCubes(
            color: Color.fromARGB(255, 14, 116, 23),
            size: 22,
          );
  }

  Future<dynamic> connectionTimeout(BuildContext context) {
    final themeData = Theme.of(context);
    final TapGestureRecognizer gestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HelpGuide()));
      };
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Couldn't locate pod :/",
              style: themeData.textTheme.headline4,
            ),
            content: RichText(
              text: TextSpan(
                  style: const TextStyle(color: brandBlack),
                  children: [
                    const WidgetSpan(
                        child: Icon(Icons.lightbulb_outline_rounded),
                        alignment: PlaceholderAlignment.middle
                        ),
                    const TextSpan(text: 'View '),
                    TextSpan(
                        text: 'help guide',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 33, 82, 243),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                        recognizer: gestureRecognizer),
                    const TextSpan(text: ' to troubleshoot')
                  ]),
            ),
            actions: [
              TextButton(
                onPressed: null,
                style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 54, 54, 54)),
                child: const Text(
                  'Retry',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ControlScreen()));
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 54, 54, 54)),
                child: const Text('Enter anyway',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        });
  }
}
