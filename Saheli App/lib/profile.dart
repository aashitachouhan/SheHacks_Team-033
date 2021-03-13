import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbit_safe/SOS%20/Sosimplicit.dart';
import 'package:fitbit_safe/bluetooth/bluetoothDetails.dart';
import 'package:fitbit_safe/heading.dart';
import 'package:fitbit_safe/SOS%20/sosexplicit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone1 = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  bool avatar = false;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(h * 0.06),
              child: Center(child:heading()),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    width: 3,
                    color: Theme.of(context).primaryColor,
                  )),
              child: SizedBox(
                height: h*0.57,
                width: w*0.8,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: h * (0.04),
                          top: h * (0.04),
                          left: h * (0.03),
                          right: h * (0.03)),
                      child: Column(
                        children: [
                          Text(
                            "Name",
                            style: GoogleFonts.galdeano(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: h * 0.032,
                                    fontWeight: FontWeight.normal)),
                            textAlign: TextAlign.start,
                          ),
                          Card(
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.0)),
                            ),
                            child: SizedBox(
                              width: w * 0.6,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                controller: name,
                                keyboardType: TextInputType.name,
                                cursorColor: Theme.of(context).primaryColor,
                                maxLength: 30,
                                maxLengthEnforced: true,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  counterStyle: TextStyle(
                                    height: double.minPositive,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                ),

                                style: GoogleFonts.concertOne(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: h * 0.032,
                                        fontWeight: FontWeight.normal)),
                                //decoration: InputDecoration(hintText: 'Enter phone number'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: h * (0.03),
                        right: h * (0.03)),
                      child: Text("Choose your Avatar",
                        style: GoogleFonts.galdeano(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: h * 0.032,
                                fontWeight: FontWeight.normal,

                          )), textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                avatar = true;
                              });
                            },
                            child: Container(
                              height: h * 0.15,
                              decoration: avatar
                                  ? BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(w * (0.2)),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 5,
                                      ),
                                    )
                                  : BoxDecoration(),
                              child: Image.asset('image/animal3.png'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                avatar= false;
                              });
                            },
                            child: Container(
                              height: h * 0.15,
                              decoration: avatar
                                  ? BoxDecoration()
                                  : BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(w * (0.2)),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 5,
                                      ),
                                    ),
                              child: Image.asset('image/animal2.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: h * (0.04),top: h*(0.04)),
                      child: Column(
                        children: [
                          Text("Emergency Contact",
                              style: GoogleFonts.galdeano(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: h * 0.032,
                                      fontWeight: FontWeight.normal))),
                          Card(
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.0)),
                            ),
                            child: SizedBox(
                              width: w * 0.6,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your number';
                                  }
                                  return null;
                                },
                                controller: phone1,
                                keyboardType: TextInputType.phone,
                                cursorColor: Theme.of(context).primaryColor,
                                maxLength: 10,
                                maxLengthEnforced: true,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  counterStyle: TextStyle(
                                    height: double.minPositive,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                ),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.concertOne(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: h * 0.032,
                                      fontWeight: FontWeight.normal),
                                ),
                                //decoration: InputDecoration(hintText: 'Enter phone number'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: h * (0.04)),
                      child: Column(
                        children: [
                          Text("Emergency Contact",
                              style: GoogleFonts.galdeano(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: h * 0.032,
                                      fontWeight: FontWeight.normal))),
                          Card(
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.0)),
                            ),
                            child: SizedBox(
                              width: w * 0.6,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your number';
                                  }
                                  return null;
                                },
                                controller: phone2,
                                keyboardType: TextInputType.phone,
                                cursorColor: Theme.of(context).primaryColor,
                                maxLength: 10,
                                maxLengthEnforced: true,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  counterStyle: TextStyle(
                                    height: double.minPositive,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                ),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.concertOne(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: h * 0.032,
                                        fontWeight: FontWeight.normal)),
                                //decoration: InputDecoration(hintText: 'Enter phone number'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: w * (0.055)),
              child: RaisedButton(
                  color: Theme.of(context).buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("Profile")
                        .doc(FirebaseAuth.instance.currentUser.phoneNumber)
                        .set({
                      "name": name.text,
                      "phone1": "+91" + phone1.text,
                      "phone2": "+91" + phone2.text,
                      "avatar": avatar ? "a1" : "a2"
                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MainPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(w * (0.03)),
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
