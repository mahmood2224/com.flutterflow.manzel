import 'package:flutter/material.dart';

class GreenPointWidget extends StatelessWidget {
  const GreenPointWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Color(0xff81D05C),
        shape: BoxShape.circle
      ),
    );
  }
}
