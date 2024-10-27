
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteBtn extends StatelessWidget {
  const WhiteBtn({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final text_theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white)
      ),
      child: Center(child: Text(text, style: text_theme.textTheme.displayLarge, textAlign: TextAlign.center,)),
    );
  }
}
