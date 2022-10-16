import 'package:flutter/material.dart';

class ListWheel extends StatefulWidget {
  const ListWheel({super.key});

  @override
  State<ListWheel> createState() => _ListWheelState();
}

class _ListWheelState extends State<ListWheel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      color: Colors.amber,
      child: Demo(),
    )));
  }
}

class Square extends StatelessWidget {
  const Square({super.key, this.size = 100.0, this.color = Colors.grey});
  final size;
  final color;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: size,
        color: color,
        height: size,
        margin: EdgeInsets.all(60),
        child: Icon(Icons.accessible_forward),
      ),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Square(),
        Square(
          color: Colors.red,
        ),
        Square(
          color: Colors.blue,
        ),
        Expanded(
          child: Flex(direction: Axis.horizontal, children: [
            SizedBox(
              width: 280,
              child: Container(
                color: Colors.indigo,
                child: Text('GROOT'),
              ),
            ),
            Expanded(
              child: Container(color: Colors.cyan, child: EffectsScroll()),
            ),
          ]),
        )
      ],
    );
  }
}

class EffectsScroll extends StatelessWidget {
  const EffectsScroll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
        useMagnifier: true,
        magnification: 1.2,
        physics: FixedExtentScrollPhysics(),
        perspective: 0.009,
        itemExtent: 50,
        children: [
          'Blink',
          'Breathe',
          'Rainbow',
          'Comet',
          'Scan',
          'Chase',
          'Random'
        ].map((e) => CardMaker(text: e)).toList());
  }
}

class CardMaker extends StatelessWidget {
  const CardMaker({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Card(
        color: Colors.red,
        child: Center(child: Text(text)),
      ),
    );
  }
}
