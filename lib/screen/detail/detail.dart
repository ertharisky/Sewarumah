import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewarumah/model/ad.dart';
import 'package:sewarumah/model/repo/transaction.dart';
import 'package:sewarumah/model/transaction.dart';
import 'package:sewarumah/network/api/transaction/transaction.dart';
import 'package:sewarumah/network/dio_client.dart';
import 'package:sewarumah/provider/transaction_provider.dart';
import 'package:sewarumah/screen/detail/widget/about.dart';
import 'package:sewarumah/screen/detail/widget/content_intro.dart';
import 'package:sewarumah/screen/detail/widget/detail_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatelessWidget {
  final ModelAd house;
  const DetailPage({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailAppBar(house: house),
          const SizedBox(height: 20),
          ContentIntro(house: house),
          const SizedBox(
            height: 20,
          ),
          // HouseInfo(),
          const SizedBox(
            height: 20,
          ),
          About(
            house: house,
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  Dio dio = Dio();
                  DioClient dioClient = DioClient(dio);
                  TransactionApi transactionApi =
                      TransactionApi(dioClient: dioClient);
                  TransactionRepository transactionRepository =
                      TransactionRepository(transactionApi: transactionApi);
                  ModelTransaction transaction =
                      await transactionRepository.createTransactionReq(
                          house.id, prefs.getString("token")!);
                  context
                      .read<TransactionProvider>()
                      .addTransaction(transaction);

                  const snackBar = SnackBar(
                    content: Text('Pemesanan berhasil!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  primary: Theme.of(context).primaryColor,
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
      )),
    );
  }
}
