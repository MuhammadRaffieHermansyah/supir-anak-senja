class Absen {
    final DateTime tanggalMasuk;
    final List<Siswa> siswa;

    Absen({
        required this.tanggalMasuk,
        required this.siswa,
    });

    factory Absen.fromJson(Map<String, dynamic> json) => Absen(
        tanggalMasuk: DateTime.parse(json["tanggal_masuk"]),
        siswa: List<Siswa>.from(json["siswa"].map((x) => Siswa.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "tanggal_masuk": "${tanggalMasuk.year.toString().padLeft(4, '0')}-${tanggalMasuk.month.toString().padLeft(2, '0')}-${tanggalMasuk.day.toString().padLeft(2, '0')}",
        "siswa": List<dynamic>.from(siswa.map((x) => x.toJson())),
    };
}

class Siswa {
    final int id;
    final String name;
    final int noAbsen;
    final String siswaClass;

    Siswa({
        required this.id,
        required this.name,
        required this.noAbsen,
        required this.siswaClass,
    });

    factory Siswa.fromJson(Map<String, dynamic> json) => Siswa(
        id: json["id"],
        name: json["name"],
        noAbsen: json["no_absen"],
        siswaClass: json["class"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "no_absen": noAbsen,
        "class": siswaClass,
    };
}
