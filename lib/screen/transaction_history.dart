import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewarumah/model/ad.dart';
import 'package:sewarumah/model/repo/transaction.dart';
import 'package:sewarumah/model/transaction.dart';
import 'package:sewarumah/network/api/transaction/transaction.dart';
import 'package:sewarumah/network/dio_client.dart';
import 'package:sewarumah/provider/ad_provider.dart';
import 'package:sewarumah/provider/transaction_provider.dart';
import 'package:sewarumah/screen/detail_transaction/detail.dart';
import 'package:sewarumah/screen/home/widget/custom_bottom_navgation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  Future<List<ModelTransaction>> ReadJsonData() async {
    final prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    DioClient dioClient = DioClient(dio);
    TransactionApi transactionApi = TransactionApi(dioClient: dioClient);
    TransactionRepository transactionRepository =
        TransactionRepository(transactionApi: transactionApi);
    return transactionRepository
        .getAllTransactionReq(prefs.getString("token")!);
  }

  getProcess(int status) {
    if (status == 1) {
      return "Dipesan";
    } else if (status == 2) {
      return "Batal";
    } else if (status == 3) {
      return "Selesai";
    }
    return "Dipesan";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: FutureBuilder<List<ModelTransaction>>(
            future: ReadJsonData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                final error = snapshot.error;
                return Center(
                  child: Text(
                    "Error: " + error.toString(),
                  ),
                );
              } else if (snapshot.hasData) {
                List<ModelTransaction> list;
                if (context
                    .read<TransactionProvider>()
                    .transactionList
                    .isEmpty) {
                  context.read<TransactionProvider>().transactionList =
                      snapshot.data!;
                }
                list = context.watch<TransactionProvider>().transactionList;
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: ((context, index) {
                        ModelAd item = context
                            .read<AdProvider>()
                            .getAd(list[index].adsId)!;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailTransactionPage(
                                          house: item,
                                        )));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Belanja",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 254, 206, 144)),
                                          child: Text(
                                            getProcess(list[index].status),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 190, 74, 3)),
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Image.asset("assets/images/offer01.jpeg",
                                          height: 50),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            item.nama,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            item.alamat,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "Total",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(fontSize: 12),
                                          ),
                                          Text(
                                            "Rp " + item.harga,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      list[index].status == 1
                                          ? Row(
                                              children: [
                                                ElevatedButton(
                                                    onPressed: (() async {
                                                      final prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      Dio dio = Dio();
                                                      DioClient dioClient =
                                                          DioClient(dio);
                                                      TransactionApi
                                                          transactionApi =
                                                          TransactionApi(
                                                              dioClient:
                                                                  dioClient);
                                                      TransactionRepository
                                                          transactionRepository =
                                                          TransactionRepository(
                                                              transactionApi:
                                                                  transactionApi);
                                                      ModelTransaction
                                                          modelTransaction =
                                                          await transactionRepository
                                                              .updateTransactionReq(
                                                                  list[index]
                                                                      .id,
                                                                  list[index]
                                                                      .adsId,
                                                                  2,
                                                                  prefs.getString(
                                                                      "token")!);

                                                      context
                                                          .read<
                                                              TransactionProvider>()
                                                          .updateTransaction(
                                                              index,
                                                              modelTransaction);

                                                      const snackBar = SnackBar(
                                                        content: Text(
                                                            'Pesanan dibatalkan!'),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    }),
                                                    child: const Text("Batal"),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .red))),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      final prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      Dio dio = Dio();
                                                      DioClient dioClient =
                                                          DioClient(dio);
                                                      TransactionApi
                                                          transactionApi =
                                                          TransactionApi(
                                                              dioClient:
                                                                  dioClient);
                                                      TransactionRepository
                                                          transactionRepository =
                                                          TransactionRepository(
                                                              transactionApi:
                                                                  transactionApi);
                                                      ModelTransaction
                                                          modelTransaction =
                                                          await transactionRepository
                                                              .updateTransactionReq(
                                                                  list[index]
                                                                      .id,
                                                                  list[index]
                                                                      .adsId,
                                                                  3,
                                                                  prefs.getString(
                                                                      "token")!);

                                                      context
                                                          .read<
                                                              TransactionProvider>()
                                                          .updateTransaction(
                                                              index,
                                                              modelTransaction);

                                                      const snackBar = SnackBar(
                                                        content: Text(
                                                            'Pesanan Selesai!'),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    },
                                                    child:
                                                        const Text("Selesai"))
                                              ],
                                            )
                                          : Container()
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
