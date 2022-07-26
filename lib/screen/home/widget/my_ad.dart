import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewarumah/model/ad.dart';
import 'package:sewarumah/model/repo/ad.dart';
import 'package:sewarumah/network/api/ad/ad.dart';
import 'package:sewarumah/network/dio_client.dart';
import 'package:sewarumah/provider/ad_provider.dart';
import 'package:sewarumah/screen/home/widget/add_ad.dart';
import 'package:sewarumah/screen/home/widget/custom_bottom_navgation_bar.dart';
import 'package:sewarumah/screen/home/widget/edit_ad.dart';
import 'package:sewarumah/widget/circle_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAdPage extends StatelessWidget {
  const MyAdPage({Key? key}) : super(key: key);

  Future<List<ModelAd>> ReadJsonData() async {
    final prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    DioClient dioClient = DioClient(dio);
    AdApi adApi = AdApi(dioClient: dioClient);
    AdRepository adRepository = AdRepository(adApi: adApi);
    return adRepository.getAllAdReq(prefs.getString("token")!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: FutureBuilder<List<ModelAd>>(
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
              context.read<AdProvider>().listAd = snapshot.data!;
              List<ModelAd> el = context.watch<AdProvider>().listAd;
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Iklan RumahKu',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TambahAdPage()));
                          },
                          child: Text(
                            'Tambah Iklan',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: el.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditAdPage(
                                            modelAd: el[index],
                                            index: index,
                                          )));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Column(
                                        children: [
                                          Text(
                                            el[index].nama,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          const SizedBox(height: 19),
                                          Text(
                                            el[index].alamat,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Positioned(
                                    right: 0,
                                    child: CircleIconButton(
                                      iconUrl: 'assets/icons/heart.svg',
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
