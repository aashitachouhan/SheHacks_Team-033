import 'package:fitbit_safe/heading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            heading(),
            SizedBox(
              height: h*(0.08),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
