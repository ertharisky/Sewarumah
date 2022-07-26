import 'package:flutter/cupertino.dart';
import 'package:sewarumah/model/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<ModelTransaction> transactionList = [];

  void addAllTransaction(List<ModelTransaction> data) {
    transactionList = data;
    notifyListeners();
  }

  void addTransaction(ModelTransaction transaction) {
    transactionList.add(transaction);
    notifyListeners();
  }

  void updateTransaction(int index, ModelTransaction transaction) {
    List<ModelTransaction> temp = [];
    for (var i = 0; i < transactionList.length; i++) {
      if (i == index) {
        temp.add(transaction);
        continue;
      }
      temp.add(transactionList[i]);
    }
    transactionList = temp;
    notifyListeners();
  }

  void deleteTransaction(int index) {
    transactionList.removeAt(index);
    notifyListeners();
  }
}
