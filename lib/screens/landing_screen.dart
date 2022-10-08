import 'package:fh_mini_app/utils/constants.dart';
import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(children: [
            Image.asset('assets/images/leaf.jpg',
            height: size.height,
            fit: BoxFit.fitHeight,
            ),

            Center(
              child: Column(
                
                children: [
                    addVerticalSpace(50),
                  Image.asset('assets/images/logo.png',
                  height: size.height*0.14,
                  ),
                  Text('Welcome to the future of food',
                  style: themeData.textTheme.headline4,),
                  addVerticalSpace(30),
                  Text('Connecting to your pod', 
                  style: themeData.textTheme.bodySmall,),
                  addVerticalSpace(10),
                  spinkit
                ],
              ),
            )
            
            
          ],),
        )
      ),
    );
  }

  final spinkit = const SpinKitWanderingCubes(
  color: Color.fromARGB(255, 14, 116, 23),
  size: 22,
);
}
