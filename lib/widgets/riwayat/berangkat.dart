import 'package:flutter/material.dart';
import 'package:tes/widgets/filter_button.dart';
import 'package:tes/widgets/riwayat/card.dart';

class Berangkat extends StatefulWidget {
  const Berangkat({super.key});

  @override
  State<Berangkat> createState() => _BerangkatState();
}

class _BerangkatState extends State<Berangkat> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: const Column(
          children: [
            SizedBox(height: 20),
            FilterButton(),
            CardRiwayat(),
            CardRiwayat(),
            CardRiwayat(),
            CardRiwayat(),
            CardRiwayat(),
            CardRiwayat(),
            CardRiwayat(),
          ],
        ),
      ),
    );
  }
}
