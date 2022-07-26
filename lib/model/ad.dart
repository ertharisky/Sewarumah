import 'dart:convert';

ModelAd modelNiatFromJson(String str) => ModelAd.fromJson(json.decode(str));

String modelNiatToJson(ModelAd data) => json.encode(data.toJson());

class ModelAd {
  int id;
  String nama;
  String alamat;
  String luas;
  String harga;
  String deskripsi;
  int penjualId;
  int status;
  ModelAd(
      {required this.id,
      required this.nama,
      required this.alamat,
      required this.deskripsi,
      required this.harga,
      required this.luas,
      required this.penjualId,
      required this.status});

  factory ModelAd.fromJson(Map<String, dynamic> json) => ModelAd(
      nama: json["nama"],
      alamat: json["alamat"],
      luas: json["luas"],
      harga: json["harga"],
      deskripsi: json["deskripsi"],
      status: json["status"],
      id: json["id"],
      penjualId: json["penjual_id"]);

  Map<String, dynamic> toJson() => {
        "name": nama,
        "alamat": alamat,
        "luas": luas,
        "harga": harga,
        "deskripsi": deskripsi,
        "status": status,
        "id": id,
        "penjual_id": penjualId
      };
}
