import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tes/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final LatLng _center = const LatLng(-8.164885, 113.695356);

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
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        trafficEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 18.0,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToHome,
        label: const Text('To the home!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToHome() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_rumah));
  }
}
