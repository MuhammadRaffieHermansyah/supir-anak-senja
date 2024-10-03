import 'package:flutter/material.dart';
import 'package:tes/models/absen.dart';

class DetailSiswa extends StatelessWidget {
  const DetailSiswa({
    super.key,
    required this.listSiswa,
  });

  final List<Siswa> listSiswa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Siswa',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.separated(
        itemCount: listSiswa.length,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        itemBuilder: (context, index) {
          Siswa siswa = listSiswa[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${index + 1}. ${siswa.name}',
                style: const TextStyle(color: Colors.black87),
              ),
              Text(
                siswa.siswaClass,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
