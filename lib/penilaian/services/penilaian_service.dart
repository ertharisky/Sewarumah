import 'package:flutter/material.dart';

//digunakan untuk implementasi State Management Provider
//diiextends dari class changenotifier dari material.dart
//ChangeNotifier membantu State Management provider dalam perubahan data
class PenilaianService extends ChangeNotifier {
  int? selectedIndex; //untuk ke penilaian edit
  //listKonsultan merupakan data awal dari penilaian
  List<Map<String, dynamic>> listKonsultan = [
    {
      'nama': 'Alifia',
      'nilai': 0,
    },
    {
      'nama': 'Johan',
      'nilai': 0,
    },
  ];

//fungsi updateNilaiKonsultan merupakan fungsi untuk mengubah nilai
//dari salah satu data listKonsultan.
//paramater index digunakan menntukan index
//paramater nilai mengubah value nilai konsultan
  void updateNilaiKonsultan(int index, int nilai) {
    List<Map<String, dynamic>> listTemp = [];
    for (var i = 0; i < listKonsultan.length; i++) {
      if (i == index) {
        listTemp.add({
          'nama': listKonsultan[i]['nama'],
          'nilai': nilai,
        });
        continue;
      }
      listTemp.add(listKonsultan[i]);
    }
    listKonsultan = listTemp;
    notifyListeners(); //fungsi dari class ChangeNotifier
  }
}
