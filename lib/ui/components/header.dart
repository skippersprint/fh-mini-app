import 'package:fh_mini_app/utils/widget_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Header extends StatelessWidget {
  const Header({super.key});

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
              Icon(
                Icons.account_circle,
                size: 35,
              ),
              addVerticalSpace(10)
            ],
          )
        ],
      ),
    );
  }
}
