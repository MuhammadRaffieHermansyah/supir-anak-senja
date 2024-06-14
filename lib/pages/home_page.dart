import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:pusher_client_fixed/pusher_client_fixed.dart';

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
  Set<Marker> _markers = {};
  late Timer _timer;
  final Stream<QuerySnapshot<Map<String, dynamic>>> _angkot =
      FirebaseFirestore.instance.collection('angkot').snapshots();
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      streamSubscription;
  // late PusherClient pusher;
  // late Channel channel;

  // void initPusher() {
  //   pusher = PusherClient(
  //     "77df57802dc27fa3feda",
  //     const PusherOptions(
  //       // host: hostEndPoint,
  //       encrypted: true,
  //       cluster: 'ap1',
  //       // auth: PusherAuth(
  //       // hostAuthEndPoint,
  //       // headers: {'Authorization': 'Bearer $token'},
  //       // ),
  //     ),
  //     autoConnect: false,
  //     enableLogging: true,
  //   );

  //   pusher.connect();

  //   pusher.onConnectionStateChange((state) {
  //     log(
  //       "previousState: ${state?.previousState}, currentState: ${state?.currentState}, socketId: ${pusher.getSocketId()}",
  //     );
  //     if (state?.currentState == 'CONNECTED') {
  //       channel = pusher.subscribe("LocationUpdate");

  //       channel.bind("OnLocationUpdate", (data) {
  //         log(data!.data.toString());
  //       });
  //     }
  //   });

  //   pusher.onConnectionError((error) {
  //     log("error: ${error?.message}");
  //   });
  // }

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  connectPusher() async {
    await pusher.init(
        apiKey: "77df57802dc27fa3feda", cluster: "ap1", onEvent: onEvent);
    await pusher.subscribe(channelName: "LocationUpdate");
    await pusher.connect();
  }

  void onEvent(PusherEvent event) {
    log('Ada Event Baru!');
    log(event.data);

    // Decode the event data
    Map<String, dynamic> data = json.decode(event.data);

    // Extract latitude and longitude
    String latitude = data['data']['lat'];
    String longitude = data['data']['long'];

    // Convert to double
    double lat = double.parse(latitude);
    double long = double.parse(longitude);

    // Create a marker
    Marker marker = Marker(
      markerId: MarkerId("1"),
      position: LatLng(lat, long),
    );

    // Update the state
    setState(() {
      _markers = {marker};
    });

    // Log the values
    log("Latitude = $lat");
    log("Longitude = $long");
  }

  // onTriggerEventPressed() async {
  //   pusher.trigger(
  //     PusherEvent(
  //       channelName: 'LocationUpdate',
  //       eventName: 'OnLocationUpdate',
  //       data: "tes"
  //     ),
  //   );
  // }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _fetchLocations() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      streamSubscription = _angkot.listen((snapshot) {
        Set<Marker> markers = snapshot.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          return Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(data['latitude'], data['longitude']),
            infoWindow: InfoWindow(
              title: data['namaAngkot'],
            ),
          );
        }).toSet();
        setState(() {
          _markers = markers;
        });
      });
    });
  }

  @override
  void initState() {
    // connectPusher();
    // _fetchLocations();
    // initPusher();
    isOffline = false;
    super.initState();
  }

  @override
  void dispose() {
    // pusher.unsubscribe("LocationUpdate"); // Replace with your channel name
    // pusher.disconnect();
    // streamSubscription.cancel();
    super.dispose();
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
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(target: _center, zoom: 16.0),
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
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (isOffline == false) {
                      setState(() {
                        isOffline = true;
                        pusher.disconnect();
                        // streamSubscription.pause();
                      });
                    } else {
                      setState(() {
                        isOffline = false;
                        connectPusher();
                        // streamSubscription.resume();
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
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.white,
      //   // onPressed: _goToHome,
      //   onPressed: () {
      //     FirebaseFirestore.instance
      //         .collection('angkot')
      //         .doc("1")
      //         .update({"namaAngkot": "AngkotBaru"});
      //   },
      //   label: const Text('Ke Rumah'),
      //   icon: const Icon(Icons.home),
      // ),
    );
  }
}
