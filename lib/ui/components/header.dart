import 'package:fh_mini_app/services/auth.dart';
import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Header extends StatelessWidget {
  Header({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FH-MINI',
                style: Theme.of(context).textTheme.headline3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/battery.png', width: 20),
                  addHorizontalSpace(10),
                  Text('77%')
                ],
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              addVerticalSpace(10)
            ],
          )
        ],
      ),
    );
  }
}
