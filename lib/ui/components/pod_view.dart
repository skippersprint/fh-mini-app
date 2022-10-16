import 'package:flutter/material.dart';

class PodView extends StatefulWidget {
  PodView({Key? key, required this.size, this.isSpin}) : super(key: key);

  final Size size;
  int? isSpin;

  @override
  State<PodView> createState() => _PodViewState();
}

class _PodViewState extends State<PodView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.size.height * 0.38,
        child: widget.isSpin == 1
            ? Image.asset('assets/images/${widget.isSpin}.png')
            : Image.asset('assets/images/${widget.isSpin}.gif'));
  }
}
