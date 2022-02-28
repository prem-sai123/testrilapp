import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/rockwell.png',
        width: MediaQuery.of(context).size.width,
        height: 150,
      ),
    );
  }
}
