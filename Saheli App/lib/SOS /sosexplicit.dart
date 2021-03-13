import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitbit_safe/SOS%20/Sosimplicit.dart';
import 'package:fitbit_safe/SOS%20/Stop.dart';
import 'package:fitbit_safe/bluetooth/bluetoothDetails.dart';
import 'package:fitbit_safe/profile.dart';
import 'package:fitbit_safe/sizeconfig.dart';
import 'package:fitbit_safe/loading/splash_joypad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Sosexplicit extends StatefulWidget {
  final BluetoothDevice server;

  const Sosexplicit({this.server});
  @override
  _SosexplicitState createState() => _SosexplicitState();
}

class _SosexplicitState extends State<Sosexplicit> {
  BluetoothConnection connection;
  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;
  bool joypadview = false; //for padbutton or joypad
  showAlertDialog(BuildContext context, Exception error,String title) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => MainPage()));},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title,style: TextStyle(color: Theme.of(context).primaryColor),),
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
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {

        isConnecting = false;
        isDisconnecting = false;
      });
      connection.input.listen((Uint8List data) {
          print('Data incoming: ${ascii.decode(data)}');
          FirebaseFirestore.instance.collection("fitbit").doc("data").set({"value": ascii.decode(data)});

          Fluttertoast.showToast(
              msg: ascii.decode(data),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.white,
              textColor: Theme.of(context).primaryColor,
              fontSize: 16.0
          );


      }).onDone(() {
        print('Disconnected by remote request');
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });

  }


  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
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
        backgroundColor:Theme.of(context).primaryColor,
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
                  if (connection != null && connection.isConnected) {
                  connection.close();
                }
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>Stop()));},
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
                style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 17,fontWeight: FontWeight.bold),
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
    return (connection != null && connection.isConnected)
        ? sos_ui
        : splash_joypad();
  }

}
