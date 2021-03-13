import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbit_safe/SOS%20/Sosimplicit.dart';
import 'package:fitbit_safe/loading/splash.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vibration/vibration.dart';
import 'package:sms_maintained/sms.dart';

class Stop extends StatefulWidget {
  @override
  _StopState createState() => _StopState();
}

class _StopState extends State<Stop> {
  void _sendSMS(List<String> phonenum,String name,Position p){
    try {
      SmsSender sender = new SmsSender();
     sender.sendSms(new SmsMessage(phone1, name+" is in danger! find at the given coordinates"+p.toString()));
      sender.sendSms(new SmsMessage(phone2, name+" is in danger! find at the given coordinates "+p.toString()));

    } catch (error) {
      print(error.toString());
    }
  }

  Future<Position> currentLocation() async {
    return Geolocator.getCurrentPosition();
  }


  String name = "Unknown";
  String phone1 = "+916354373919";
  String phone2 = "+916354373919";
  Future<dynamic> getData() async {
    final DocumentReference document = FirebaseFirestore.instance
        .collection("Profile")
        .doc(FirebaseAuth.instance.currentUser.phoneNumber);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        name = snapshot['name'];
        phone1 = snapshot['phone1'];
        phone2 = snapshot['phone2'];
      });
    });
  }
@override
  void initState() {
  super.initState();
  getData();
    }

  @override
  void dispose() {
    super.dispose();
    Vibration.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
                  future: currentLocation(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _sendSMS([phone1,phone2],name, snapshot.data);
                      FirebaseFirestore.instance
                          .collection("Location")
                          .doc(FirebaseAuth.instance.currentUser.phoneNumber)
                          .set({
                        "current": new GeoPoint(
                            snapshot.data.latitude, snapshot.data.longitude)
                      });
                      return Sosimplicit();

                    }
                    else{
                      return splash();
                    }
                  },

    );
  }
}
