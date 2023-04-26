import 'package:eleventwos/constants/_const_theme.dart';
import 'package:flutter/material.dart';

class ElevenTwos extends StatefulWidget {
  const ElevenTwos({Key? key}) : super(key: key);

  @override
  State<ElevenTwos> createState() => _ElevenTwosState();
}

class _ElevenTwosState extends State<ElevenTwos> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TwoTheme.themeDark,
    );
  }
}
