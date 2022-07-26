import 'package:dio/dio.dart';
import 'package:sewarumah/network/constant/endpoint.dart';
import 'package:sewarumah/network/dio_client.dart';

class AdApi {
  final DioClient dioClient;

  AdApi({required this.dioClient});

  Future<Response> getAllAd(String token) async {
    try {
      final Response response = await dioClient.get(Endpoints.ad,
          options: Options(headers: {"Authorization": "bearer " + token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> showProduct(String token) async {
    try {
      final Response response = await dioClient.get(
          Endpoints.baseUrl + "/showproduct",
          options: Options(headers: {"Authorization": "bearer " + token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createAd(String nama, String alamat, String luas,
      String harga, String deskripsi, String token) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.ad,
        data: {
          "nama": nama,
          "alamat": alamat,
          "luas": luas,
          "harga": harga,
          "deskripsi": deskripsi,
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

  Future<Response> updateAd(int id, String nama, String alamat, String luas,
      String harga, String deskripsi, String type, String token) async {
    try {
      final Response response = await dioClient.put(
        Endpoints.ad + "/$id",
        data: {
          "nama": nama,
          "alamat": alamat,
          "luas": luas,
          "harga": harga,
          "deskripsi": deskripsi,
          "type": type
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
        Endpoints.ad + "/$id",
        options: Options(
          headers: {"Authorization": "bearer " + token},
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> showAd(int id, String token) async {
    try {
      final Response response = await dioClient.get(
        Endpoints.ad + "/$id",
        options: Options(
          headers: {"Authorization": "bearer " + token},
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> showAll(String token) async {
    try {
      final Response response = await dioClient.get(
        Endpoints.baseUrl + "/showall",
        options: Options(
          headers: {"Authorization": "bearer " + token},
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
