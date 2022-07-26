import 'dart:convert';

modelTransactionFromJson(String str) =>
    ModelTransaction.fromJson(json.decode(str));

String modelTransactionToJson(ModelTransaction data) =>
    json.encode(data.toJson());

class ModelTransaction {
  int id;
  int adsId;
  int pembeliId;
  int status;

  ModelTransaction(
      {required this.id,
      required this.adsId,
      required this.pembeliId,
      required this.status});

  factory ModelTransaction.fromJson(Map<String, dynamic> json) =>
      ModelTransaction(
          status: json["status"],
          id: json["id"],
          adsId: json["ads_id"],
          pembeliId: json["pembeli_id"]);

  Map<String, dynamic> toJson() =>
      {"status": status, "id": id, "pembeli_id": pembeliId, "ads_id": adsId};
}
