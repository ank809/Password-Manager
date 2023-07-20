import 'package:flutter/material.dart';
class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('Asset/images/white.png'),
      ],
    );
  }
}