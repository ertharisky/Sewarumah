import 'package:flutter/cupertino.dart';
import 'package:sewarumah/model/ad.dart';

class AdProvider with ChangeNotifier {
  List<ModelAd> listAd = [];
  List<ModelAd> listAllAd = [];
  List<ModelAd> listRecomended = [];

  void addAllAd(List<ModelAd> data) {
    listAd = data;
    notifyListeners();
  }

  ModelAd? getAd(int id) {
    for (var i = 0; i < listAllAd.length; i++) {
      print("listAllAd id : ${listAllAd[i].id} \n adsId : $id");
      if (listAllAd[i].id == id) {
        return listAllAd[i];
      }
    }
    return null;
  }

  void addAd(ModelAd ad) {
    listAd.add(ad);
    notifyListeners();
  }

  void updateAd(int index, ModelAd ad) {
    List<ModelAd> temp = [];
    for (var i = 0; i < listAd.length; i++) {
      if (i == index) {
        temp.add(ad);
        continue;
      }
      temp.add(listAd[i]);
    }
    listAd = temp;
    notifyListeners();
  }

  void deleteAd(int index) {
    listAd.removeAt(index);
    notifyListeners();
  }

  void addAllRecomended(List<ModelAd> data) {
    listRecomended = data;
    notifyListeners();
  }

  void addRecomended(ModelAd ad) {
    listRecomended.add(ad);
    notifyListeners();
  }

  void updateRecomended(int index, ModelAd ad) {
    List<ModelAd> temp = [];
    for (var i = 0; i < listRecomended.length; i++) {
      if (i == index) {
        temp.add(ad);
        continue;
      }
      temp.add(listRecomended[i]);
    }
    listRecomended = temp;
    notifyListeners();
  }

  void deleteRecomended(int index) {
    listRecomended.removeAt(index);
    notifyListeners();
  }
}
