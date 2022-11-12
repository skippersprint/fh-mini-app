import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset("assets/images/leaf.png"),
                                    Text(
                                      'Botanix  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
      Center(
          child: SpinKitWanderingCubes(
        color: Color.fromARGB(255, 19, 55, 121),
        size: 50.0,
      )),
    ]);
  }
}
