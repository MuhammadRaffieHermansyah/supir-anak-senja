// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/api_key.dart';
import 'package:tes/pages/change_password.dart';
import 'package:tes/pages/introduction.dart';
import 'package:http/http.dart' as http;
import 'package:tes/pages/login_page.dart';
import 'package:tes/pages/update_account.dart';
import 'package:tes/widgets/utilities.dart';

class OptionProfile extends StatefulWidget {
  const OptionProfile({super.key});

  @override
  State<OptionProfile> createState() => _OptionProfileState();
}

class _OptionProfileState extends State<OptionProfile> {
  void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse(ApiKey.logout);
    final response = await http.post(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      await prefs.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }
  }

  void dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(""),
          content: Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Apakah Anda Yakin ingin keluar?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Tidak",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Utilities.showLoaderDialog(context);
                    _logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Iya",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 240,
          decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UpdateAccount(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Akun',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.shield,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Data Profil',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                width: 18,
                              ),
                            ],
                          ),
                          Text(
                            'Periksa atau ubah data anda',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangePassword(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Keamanan',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.lock,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Ubah Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Ubah password akun anda',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 58,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Introduction(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Tentang',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.info,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Instruksi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Instruksi aplikasi',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 35),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 60),
          child: ElevatedButton(
            onPressed: () {
              dialog(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.red,
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Sign Out',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
