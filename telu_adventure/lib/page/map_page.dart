import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telu_adventure/controllers/map_controller.dart';
import 'package:telu_adventure/model/gedung_model.dart';

class map_page extends StatefulWidget {
  map_page({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<map_page> {
  late GoogleMapController _controller;
  final mapCon _locationController = mapCon();
  final LatLng _initialPosition =
      const LatLng(-6.8909, 107.6102); // Telkom University's coordinate

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() async {
    List<gedung> locations =
        await _locationController.getLocationsFromFirestore();

    setState(() {
      _markers = locations.map((location) {
        return Marker(
          markerId: MarkerId(location.namaGedung),
          position:
              LatLng(double.parse(location.Lat), double.parse(location.Long)),
          infoWindow: InfoWindow(title: location.namaGedung),
        );
      }).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Page')),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: _initialPosition, zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: _markers,
      ),
    );
  }
}
