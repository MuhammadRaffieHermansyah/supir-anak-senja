import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/get-models/get_asben.dart';
import 'package:tes/models/absen.dart';
import 'package:tes/providers/absen_provider.dart';
import 'package:tes/widgets/riwayat/card_riwayat.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  final formatter = DateFormat('dd MMMM yyyy');
  DateTimeRange _selectedDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  DateTime now = DateTime.now();
  bool isDateRangeChange = false;
  bool isSelectedDateChange = false;

  Future<void> selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      barrierColor: Colors.orange,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDate,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        isDateRangeChange = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange,
        title: const Center(
          child: Text(
            'Riwayat Absen',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              selectDateRange(context);
            },
            icon: const Icon(
              Icons.filter_alt_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: FutureBuilder<GetAbsen>(
          future: AbsenProvider.getAbsen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                ),
              );
            } else {
              final List<Absen> data = snapshot.data!.data;
              if (data.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tidak ada data !',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'ATAU',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Semua siswa sudah ter-absen !',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Absen item = data[index];
                  List<Siswa> listSiswa = item.siswa;
                  return CardRiwayat(
                    tanggal: formatter.format(item.tanggalMasuk),
                    listStudent: listSiswa,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: data.length,
              );
            }
          },
        ),
      ),
    );
  }
}
