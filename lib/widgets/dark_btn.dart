
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DarkBtn extends StatelessWidget {
  const DarkBtn({super.key, required this.text, required this.btn_width, required this.btn_height});
  final String text;
  final double btn_width;
  final double btn_height;
  @override
  Widget build(BuildContext context) {
    final text_theme = Theme.of(context);
    return Container(
      width: btn_width,
      height: btn_height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: <Color>[
          Color(0xff7365A2),
          Color(0xff70426A),
          Color(0xffEA6D79),
          Color(0xffFDA187),
        ],
            begin: Alignment.topLeft,
            end: Alignment(1.5, 1)
        ),
      ),
      child: Center(child: Text(text, style: text_theme.textTheme.displaySmall, textAlign: TextAlign.center,)),
    );
  }
}