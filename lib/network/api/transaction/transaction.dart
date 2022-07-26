import 'package:dio/dio.dart';
import 'package:sewarumah/network/constant/endpoint.dart';
import 'package:sewarumah/network/dio_client.dart';

class TransactionApi {
  final DioClient dioClient;

  TransactionApi({required this.dioClient});

  Future<Response> getAllTransaction(String token) async {
    try {
      final Response response = await dioClient.get(Endpoints.transaction,
          options: Options(headers: {"Authorization": "bearer " + token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createTransaction(int id, String token) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.transaction,
        data: {
          "ads_id": id,
        },
        options: Options(
          followRedirects: false,
          headers: {
            "Authorization": "bearer " + token,
            "Accept": "application/json"
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateTransaction(
      int id, int adsId, int status, String token) async {
    try {
      final Response response = await dioClient.put(
        Endpoints.transaction + "/$id",
        data: {
          "ads_id": adsId,
          "status": status,
        },
        options: Options(
          headers: {"Authorization": "bearer " + token},
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAd(int id, String token) async {
    try {
      await dioClient.delete(
        Endpoints.transaction + "/$id",
        options: Options(
          headers: {"Authorization": "bearer " + token},
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
