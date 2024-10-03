import 'package:flutter/material.dart';
import 'package:tes/models/absen.dart';
import 'package:tes/pages/detail_siswa.dart';

class CardRiwayat extends StatelessWidget {
  const CardRiwayat({
    super.key,
    required this.tanggal,
    required this.listStudent,
  });

  final String tanggal;
  final List<Siswa> listStudent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tanggal,
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailSiswa(
                      listSiswa: listStudent,
                    ),
                  ),
                );
              },
              child: const Text(
                'Lihat Semua',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // child: Column(
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           listStudent[0].name,
          //           style: const TextStyle(
          //             color: Colors.grey,
          //             fontSize: 12,
          //           ),
          //         ),
          //         Text(
          //           'Kelas ${listStudent[0].siswaClass}',
          //           style: const TextStyle(
          //             color: Colors.black,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 12,
          //           ),
          //         ),
          //       ],
          //     ),
          //     const SizedBox(
          //       height: 4,
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           listStudent[1].name,
          //           style: const TextStyle(
          //             color: Colors.grey,
          //             fontSize: 12,
          //           ),
          //         ),
          //         Text(
          //           'Kelas ${listStudent[1].siswaClass}',
          //           style: const TextStyle(
          //             color: Colors.black,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 12,
          //           ),
          //         ),
          //       ],
          //     ),
          //     const SizedBox(
          //       height: 4,
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           listStudent[2].name,
          //           style: const TextStyle(
          //             color: Colors.grey,
          //             fontSize: 12,
          //           ),
          //         ),
          //         Text(
          //           'Kelas ${listStudent[2].siswaClass}',
          //           style: const TextStyle(
          //             color: Colors.black,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 12,
          //           ),
          //         ),
          //       ],
          //     ),
          //     const SizedBox(
          //       height: 4,
          //     ),
          //   ],
          // ),
          child: Column(
            children: List.generate(3, (index) {
              if (index < listStudent.length) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      listStudent[index].name,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Kelas ${listStudent[index].siswaClass}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.4,
        )
      ],
    );
  }
}
