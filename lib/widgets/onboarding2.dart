import 'package:flutter/material.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Selamat datang \n sopir Anak Senja',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        Image.asset(
          'assets/images/onboarding.png',
          width: 270,
          height: 270,
        ),
        const Text(
          'Aplikasi untuk memberikan informasi\n lokasi terkini angkot.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
