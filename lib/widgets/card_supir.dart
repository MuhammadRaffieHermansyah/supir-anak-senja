import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardSupir extends StatefulWidget {
  const CardSupir({super.key});

  @override
  State<CardSupir> createState() => _CardSupirState();
}

class _CardSupirState extends State<CardSupir> {
  late Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('dd MMMM yyyy, HH:mm:ss');
    setState(() {
      _currentTime = formatter.format(now);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      padding: const EdgeInsets.all(12),
      width: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profil Supir',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                _currentTime,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 11,
                ),
              )
            ],
          ),
          const SizedBox(height: 7),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    // backgroundImage: AssetImage(
                    //   'assets/images/contact-sopir.png',
                    // ),
                    child: Icon(Icons.person),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Budi Suparno',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '-6.098234098 106.09823409',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
