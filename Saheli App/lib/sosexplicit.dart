import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Sosexplicit extends StatefulWidget {
  @override
  _SosexplicitState createState() => _SosexplicitState();
}

class _SosexplicitState extends State<Sosexplicit> {
  showAlertDialog(BuildContext context, Exception error,String title) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => MainPage()));},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title,style: TextStyle(color: Color(0xfff20b0b)),),
      content: Text(error.toString()),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
 

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double h = SizeConfig.safeBlockVertical * 100;
    double w = SizeConfig.safeBlockHorizontal * 100;
    var sos_ui= Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.home),color: Colors.white,onPressed: (){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => MainPage()));
        },),
        backgroundColor: Color(0xffD02850),
        title: Padding(padding:EdgeInsets.symmetric(horizontal: w*(0.03)),child: Text("Emergency!",style: TextStyle(color: Colors.white,fontSize: 25),)),

      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
         Center(
           child: Container(
             width: w*0.7,
              child: GestureDetector(
                child: Image.asset("image/pinksos.png"),
                onTap: () {
                  },
              ),
            ),
         ),
          SizedBox(height: h/5,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              child: Text(
                "On pressing the SOS button \n or on detecting an accidental event \n live coordinates will be sent \n to your emergency contacts",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xffD02850),fontSize: 17,fontWeight: FontWeight.bold),
              ),
              onTap: (){
                Future.delayed(const Duration(seconds: 5), () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>Stop()));
                });

              },
            ),
          )
        ],
      ),
    );
    return sos_ui;
        
  }

}
