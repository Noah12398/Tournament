import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Color(0xFF212121),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        "Tournament",
        style: TextStyle(
          color: Colors.yellow,
          fontSize: 21,
          fontWeight: FontWeight.bold
        )
      ),
      leading: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFF212121),
          borderRadius: BorderRadius.circular(12)
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/icons/settings_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.svg',
          height: 29,
          width: 29,
        ),
      ),
        centerTitle:  true,
        backgroundColor: Color(0xFF212121),
    );
  }
}