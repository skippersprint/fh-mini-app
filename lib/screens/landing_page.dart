import 'package:fh_mini_app/screens/wrapper.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
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
                  color: Color.fromARGB(255, 0, 17, 51),
                  borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(130.0),
                    bottomRight: const Radius.circular(130.0),
                  ),
                )),
              ),
              Column(
                children: [
                  Text(
                    'Botanix',
                    style: TextStyle(
                        color: Color.fromARGB(255, 29, 29, 29), fontSize: 50),
                  ),
                  Text(
                    'Indoor farming made easy',
                    style: TextStyle(color: Colors.black),
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
                            Color.fromARGB(255, 168, 255, 117)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ))),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Wrapper()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Started for Free ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 63, 63, 63),
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 61, 61, 61),
                          size: 14,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Center(
            child: Container(
              height: size.height * 0.18,
              width: size.height * 0.18,
              child: Image(image: AssetImage('assets/images/logo.png')),
            ),
          )
        ],
      ),
    ));
  }
}
