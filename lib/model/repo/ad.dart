import 'package:sewarumah/model/ad.dart';
import 'package:sewarumah/network/api/ad/ad.dart';
import 'package:dio/dio.dart';
import 'package:sewarumah/network/dio_exception.dart';

class AdRepository {
  final AdApi adApi;
  AdRepository({required this.adApi});
  Future<List<ModelAd>> getAllAdReq(String token) async {
    try {
      final response = await adApi.getAllAd(token);
      final ad = (response.data['data'] as List)
          .map((e) => ModelAd.fromJson(e))
          .toList();
      return ad;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<ModelAd>> showAllAdReq(String token) async {
    try {
      final response = await adApi.showAll(token);
      final ad = (response.data['data'] as List)
          .map((e) => ModelAd.fromJson(e))
          .toList();
      return ad;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<ModelAd>> showProductReq(String token) async {
    try {
      final response = await adApi.showProduct(token);
      final ad = (response.data['data'] as List)
          .map((e) => ModelAd.fromJson(e))
          .toList();
      return ad;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ModelAd> createAdReq(String nama, String alamat, String luas,
      String harga, String deskripsi, String token) async {
    try {
      final response =
          await adApi.createAd(nama, alamat, luas, harga, deskripsi, token);
      return ModelAd.fromJson(response.data["data"]);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ModelAd> updateAdReq(int id, String nama, String alamat, String luas,
      String harga, String deskripsi, String type, String token) async {
    try {
      final response = await adApi.updateAd(
          id, nama, alamat, luas, harga, deskripsi, type, token);
      return ModelAd.fromJson(response.data["data"]);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> deleteAdReq(int id, String token) async {
    try {
      final response = await adApi.deleteAd(id, token);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ModelAd> showAdReq(int id, String token) async {
    try {
      final response = await adApi.showAd(id, token);
      return ModelAd.fromJson(response.data["data"]);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
