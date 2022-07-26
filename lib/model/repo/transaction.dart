import 'package:dio/dio.dart';
import 'package:sewarumah/model/transaction.dart';
import 'package:sewarumah/network/api/transaction/transaction.dart';
import 'package:sewarumah/network/dio_exception.dart';

class TransactionRepository {
  final TransactionApi transactionApi;
  TransactionRepository({required this.transactionApi});
  Future<List<ModelTransaction>> getAllTransactionReq(String token) async {
    try {
      final response = await transactionApi.getAllTransaction(token);
      final transaction = (response.data['data'] as List)
          .map((e) => ModelTransaction.fromJson(e))
          .toList();
      return transaction;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ModelTransaction> createTransactionReq(int id, String token) async {
    try {
      final response = await transactionApi.createTransaction(id, token);
      return ModelTransaction.fromJson(response.data["data"]);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ModelTransaction> updateTransactionReq(
      int id, int adsId, int status, String token) async {
    try {
      final response =
          await transactionApi.updateTransaction(id, adsId, status, token);
      return ModelTransaction.fromJson(response.data["data"]);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
