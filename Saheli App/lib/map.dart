import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController _controller;
  List<Marker> m = [];
  String name = "Danger";
  Future<dynamic> getData() async {
    final DocumentReference document = FirebaseFirestore.instance
        .collection("fitbit")
        .doc("profile");

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        name = snapshot['name'];
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:Theme.of(context).primaryColor,
        title: Center(child: Text("Map Tracker",style: TextStyle(color: Colors.white),)),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        trafficEnabled: true,
        initialCameraPosition:
        CameraPosition(target: LatLng(19.0760,72.8777), zoom: 10.0),
        markers: Set.from(m),
        onTap:_ontapMarker,
        onMapCreated: (GoogleMapController controller){
          _controller=controller;
        },
      ),
    );
  }
  _ontapMarker(value) async{
    List<Marker> n = [];
    GeoPoint g;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Location").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      g=a["current"];
      n.add(Marker(position: LatLng(g.latitude,g.longitude),infoWindow:InfoWindow(title: a.id),markerId: MarkerId("Danger"),icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose)));

    }
     setState(() {
      m=[];
      m=n;
  });
}
}
