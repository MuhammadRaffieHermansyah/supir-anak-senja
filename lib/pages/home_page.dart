import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool isOffline = false;
  final LatLng _center = const LatLng(-8.164878, 113.695402);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final Set<Marker> _markers = {
    const Marker(
        markerId: MarkerId('mark_1'),
        position: LatLng(-8.173943, 113.698233),
        infoWindow: InfoWindow(
          title: 'Rumah Mama IDA',
        ),
        icon: BitmapDescriptor.defaultMarker),
    const Marker(
        markerId: MarkerId('mark_1'),
        position: LatLng(-8.164885, 113.695356),
        infoWindow: InfoWindow(
          title: 'Ini Jalan Bungur Deker Tamara Management',
        ),
        icon: BitmapDescriptor.defaultMarker),
  };

  static const CameraPosition _rumah = CameraPosition(
      // bearing: 192.8334901395799,
      target: LatLng(-8.173943, 113.698233),
      // tilt: 59.440717697143555,
      zoom: 25.151926040649414);

  Future<void> _goToHome() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_rumah));
  }

  @override
  void initState() {
    isOffline = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Live Tracking',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            trafficEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  backgroundImage: AssetImage('assets/images/home.png'),
                  backgroundColor: Colors.grey,
                ),
                Container(
                  width: 110,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isOffline ? 'Lagi Online' : 'Lagi Offline',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (isOffline == false) {
                      setState(() {
                        isOffline = true;
                      });
                    } else {
                      setState(() {
                        isOffline = false;
                      });
                    }
                  },
                  icon: isOffline
                      ? const Icon(
                          Icons.radio_button_checked,
                          size: 40,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.radio_button_checked,
                          size: 40,
                          color: Colors.red,
                        ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: _goToHome,
        label: const Text('Ke Rumah'),
        icon: const Icon(Icons.home),
      ),
    );
  }
}
