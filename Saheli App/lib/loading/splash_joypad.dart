import 'package:fitbit_safe/heading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
class splash_joypad extends StatefulWidget {
  @override
  _splash_joypadState createState() => _splash_joypadState();
}
//splash screen with circularprogressindicatior for intuitive connection check
class _splash_joypadState extends State<splash_joypad> {
  bool a = false;
  route() {
    setState(() {
      a=true;
    });
  }
  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration,route);
  }

  @override
  void initState() {
    super.initState();
   startTime();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    var back = Column(children: [
      Text("CANNOT CONNECT",
          style: GoogleFonts.galdeano(
              textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold))),
      SizedBox(height: h*(0.2),),
      Container(
        width: w * (0.6),
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            elevation: 7,
            color:Theme.of(context).primaryColor,
            child: Text('Back',
                style: GoogleFonts.galdeano(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ))),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      )
    ]);
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
            a?back:CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
