import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapsUI extends StatefulWidget {
  GoogleMapsUI(
      {Key key,
      this.mySearchFieldAndButton,
      this.bookMarkers,
      this.myPopUp,
      this.myQRCode})
      : super(key: key);
  final Widget mySearchFieldAndButton;
  final Widget myPopUp;
  final Widget myQRCode;
  Set<Marker> bookMarkers = {};

  @override
  _GoogleMapsUIState createState() => _GoogleMapsUIState();
}

class _GoogleMapsUIState extends State<GoogleMapsUI> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  static double latitude, longitude;

  @override
  void initState() {
    super.initState();
    latitude = 34.0043534;
    longitude = 71.5181241;
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker(String imagePath) async {
    ByteData byteData = await DefaultAssetBundle.of(context).load(imagePath);
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      widget.bookMarkers.add(marker);
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker("images/personicon.png");
      var location = await _locationTracker.getLocation();
      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        latitude = newLocalData.latitude;
        longitude = newLocalData.longitude;
        if (_controller != null) {
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          mapType: MapType.terrain,
          initialCameraPosition: initialLocation,
          markers:
              Set.of((widget.bookMarkers != null) ? widget.bookMarkers : []),
          circles: Set.of((circle != null) ? [circle] : []),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
              child: Icon(Icons.location_searching),
              onPressed: () {
                getCurrentLocation();
                _controller.animateCamera(CameraUpdate.newCameraPosition(
                    new CameraPosition(
                        bearing: 0,
                        target: LatLng(latitude, longitude),
                        tilt: 0,
                        zoom: 15.00)));
              }),
        ),
        widget.mySearchFieldAndButton,
        widget.myPopUp,
        widget.myQRCode,
      ],
    );
  }
}
