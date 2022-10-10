import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  bool isGif = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  child: isGif
                      ? Image.asset('assets/images/miniRotating.gif')
                      : Image.asset('assets/images/miniHalt.png')),
            ),
            FloatingActionButton(onPressed: () {
              setState(() {
                isGif = !isGif;
              });
            })
          ],
        ),
      ),
    );
  }
}
