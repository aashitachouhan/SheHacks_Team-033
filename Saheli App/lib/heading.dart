import 'package:fitbit_safe/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double h = SizeConfig.safeBlockVertical*100;
    double w = SizeConfig.safeBlockHorizontal*100 ;
    return RichText(
      text: TextSpan(
        /*defining default style is optional */
        children: <TextSpan>[
          TextSpan(
              text: 'SAHEL ',
              style: GoogleFonts.galdeano(
                  textStyle: TextStyle(
                      color: Color(0xffD02850),
                      fontSize: h*0.056,
                      fontWeight: FontWeight.bold))),
          TextSpan(
              text: 'i',
              style: GoogleFonts.galdeano(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: h*0.068,
                      fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
