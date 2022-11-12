import 'package:fh_mini_app/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key});

  var state = false;
  void toggleState() {
    state = !state;
  }

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    if (widget.state) {
      return Authenticate();
    } else {
      return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height * 0.45,
                  width: size.width,
                  child: Container(
                      decoration: BoxDecoration(
                    color: Color.fromARGB(255, 16, 24, 39),
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(120.0),
                      bottomRight: const Radius.circular(120.0),
                    ),
                  )),
                ),
                Column(
                  children: [
                    Text(
                      'Botanix',
                      style: TextStyle(fontSize: 42),
                    ),
                    Text(
                      'Indoor farming made easy',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(3),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 177, 245, 138)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                          ))),
                      onPressed: () {
                        setState(() {
                          widget.toggleState();
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Get Started for Free ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 61, 61, 61),
                            size: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: ((size.height * 0.45) - (size.height * 0.07)),
              left: ((size.width * 0.5) - (size.height * 0.07)),
              child: Container(
                  height: size.height * 0.14,
                  width: size.height * 0.14,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 110, 110, 110),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/leaf.png'))),
                  )),
            )
          ],
        ),
      ));
    }
  }
}
