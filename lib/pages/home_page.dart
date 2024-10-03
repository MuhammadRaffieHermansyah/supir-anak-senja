import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/api_key.dart';
import 'package:tes/pages/contact_supir.dart';
import 'package:tes/widgets/card_supir.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool isOffline = false;
  final Set<Marker> _markers = {};

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  Stream<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.best,
  ));

  Future<void> _startTracking() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Layanan lokasi tidak diaktifkan');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Izin lokasi ditolak');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Izin lokasi ditolak secara permanen');
    }

    Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      final url = Uri.parse(ApiKey.updateLocation);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "latitude": position.latitude.toString(),
        "longitude": position.longitude.toString(),
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    isOffline = false;
    _startTracking();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Live Tracking',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            fortyFiveDegreeImageryEnabled: true,
            compassEnabled: true,
            trafficEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: const CameraPosition(
              target: LatLng(-8.268689, 113.362703),
              zoom: 16.0,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactSupir(),
                    ),
                  );
                },
                child: const CardSupir(),
              ),
              const SizedBox(height: 40)
            ],
          ),
        ],
      ),
    );
  }
}
