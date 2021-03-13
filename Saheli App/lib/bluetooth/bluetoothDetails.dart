import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbit_safe/MobileAuth/phone_otp.dart';
import 'package:fitbit_safe/map.dart';
import 'package:fitbit_safe/profile.dart';
import 'package:fitbit_safe/SOS%20/sosexplicit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../heading.dart';
import '../sizeconfig.dart';
import 'DiscoveryPage.dart';
import 'SelectBondedDevicePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String _address = "...";
  String _name = "...";
  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  bool _autoAcceptPairingRequests = false;
  String name = "Unknown";
  String age = "";
  bool avatar = true;
  Future<dynamic> getData() async {
    final DocumentReference document = FirebaseFirestore.instance
        .collection("Profile")
        .doc(FirebaseAuth.instance.currentUser.phoneNumber);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        name = snapshot['name'];
        if (snapshot['avatar'] == "a1")
          avatar = true;
        else
          avatar = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });

  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double h = SizeConfig.safeBlockVertical * 100;
    double w = SizeConfig.safeBlockHorizontal * 100;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xfff7f7f7),
      drawer: Drawer(
        elevation: 20,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Column(
          // Important: Remove any padding from the ListView.

          children: <Widget>[
            Container(
              height: h * 0.4,
              child: DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: h * 0.035,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Center(
                        child: Column(children: [
                      Container(
                        height: h * (0.15),
                        child: avatar
                            ? Image.asset(
                                "image/animal3.png",
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "image/animal2.png",
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(height: h * 0.01),
                      Text(
                        name,
                        style: GoogleFonts.galdeano(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: h * 0.032,
                        )),
                      ),
                      SizedBox(height: h * 0.005),
                    ])),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: h * 0.032,
                  ),
                  title: Text(
                    'Edit Profile',
                    style: GoogleFonts.galdeano(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: h * 0.032,
                    )),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Profile()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: h * 0.032,
                  ),
                  title: Text(
                    'Device Settings',
                    style: GoogleFonts.galdeano(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: h * 0.032,
                    )),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    FlutterBluetoothSerial.instance.openSettings();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.my_location_outlined,
                    color: Colors.black,
                    size: h * 0.032,
                  ),
                  title: Text(
                    'Locate Danger',
                    style: GoogleFonts.galdeano(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: h * 0.032,
                        )),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Map()));
                  },
                ),
              ]),
            ),
            Container(
              color: Colors.black,
              width: double.infinity,
              height: 0.3,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
                size: h * 0.032,
              ),
              title: Text(
                'Logout',
                style: GoogleFonts.galdeano(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: h * 0.032,
                )),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage() tujhe bhej diy));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Bluetooth Settings',
            style: GoogleFonts.galdeano(
                textStyle: TextStyle(
              color: Colors.white,
              fontSize: h * 0.032,
            ))),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: h * 0.1, horizontal: w * 0.1),
                child:heading()),
            SwitchListTile(
              title: Text('Bluetooth State',
                  style: GoogleFonts.galdeano(
                      textStyle: TextStyle(
                    color: Color(0xff747292),
                    fontSize: h * 0.032,
                  ))),
              subtitle: Text(_bluetoothState.toString()),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                // Do the request and update with the true value then
                future() async {
                  // async lambda seems to not working
                  if (value)
                    await FlutterBluetoothSerial.instance.requestEnable();
                  else
                    await FlutterBluetoothSerial.instance.requestDisable();
                }

                future().then((_) {
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: Text('Local adapter address',
                  style: GoogleFonts.galdeano(
                      textStyle: TextStyle(
                    color: Color(0xff747292),
                    fontSize: h * 0.032,
                  ))),
              subtitle: Text(_address),
            ),
            ListTile(
              title: Text('Local adapter name',
                  style: GoogleFonts.galdeano(
                      textStyle: TextStyle(
                    color: Color(0xff747292),
                    fontSize: h * 0.032,
                  ))),
              subtitle: Text(_name),
              onLongPress: null,
            ),
            SizedBox(
              height: h * 0.08,
            ),

            Container(
              width: h * (0.38),
              height: h*(0.08),
              child: RaisedButton(
                elevation: 7,
                color:Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding:EdgeInsets.all(h * 0.010),
                  child: Text('Connect to paired device',
                      style: GoogleFonts.galdeano(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: h * 0.029,
                              fontWeight: FontWeight.bold))),
                ),
                onPressed: () async {
                  if (_bluetoothState.isEnabled) {
                    final BluetoothDevice selectedDevice =
                        await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SelectBondedDevicePage(
                              checkAvailability: false);
                        },
                      ),
                    );

                    if (selectedDevice != null) {
                      print('Connect -> selected ' + selectedDevice.address);
                      _startChat(context, selectedDevice);
                    } else {
                      print('Connect -> no device selected');
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Bluetooth Disabled!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Theme.of(context).primaryColor,
                        fontSize: 16.0
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Sosexplicit(server: server);
        },
      ),
    );
  }
}
