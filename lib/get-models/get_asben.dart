import 'package:tes/models/absen.dart';

class GetAbsen {
  final List<Absen> data;

  GetAbsen({
    required this.data,
  });

  factory GetAbsen.fromJson(Map<String, dynamic> json) => GetAbsen(
        data: List<Absen>.from(json["data"].map((x) => Absen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
