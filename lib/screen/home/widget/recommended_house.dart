import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewarumah/model/ad.dart';
import 'package:sewarumah/model/repo/ad.dart';
import 'package:sewarumah/network/api/ad/ad.dart';
import 'package:sewarumah/network/dio_client.dart';
import 'package:sewarumah/provider/ad_provider.dart';
import 'package:sewarumah/screen/detail/detail.dart';
import 'package:sewarumah/widget/circle_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendedHouse extends StatelessWidget {
  Future<List<ModelAd>> ReadJsonData() async {
    final prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    DioClient dioClient = DioClient(dio);
    AdApi adApi = AdApi(dioClient: dioClient);
    AdRepository adRepository = AdRepository(adApi: adApi);
    return adRepository.showProductReq(prefs.getString("token")!);
  }

  Future<List<ModelAd>> GetAds() async {
    final prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    DioClient dioClient = DioClient(dio);
    AdApi adApi = AdApi(dioClient: dioClient);
    AdRepository adRepository = AdRepository(adApi: adApi);
    return adRepository.showAllAdReq(prefs.getString("token")!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelAd>>(
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
            GetAds()
                .then((value) => context.read<AdProvider>().listAllAd = value);
            context.read<AdProvider>().listRecomended = snapshot.data!;
            List<ModelAd> list = context.watch<AdProvider>().listRecomended;
            if (list.isEmpty) {
              return Container();
            }
            return Container(
              padding: const EdgeInsets.all(15),
              height: 340,
              child: ListView.separated(
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DetailPage(house: list[index]);
                          }));
                        },
                        child: Container(
                          height: 300,
                          width: 230,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Stack(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/offer01.jpeg",
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                right: 15,
                                top: 15,
                                child: CircleIconButton(
                                  iconUrl: 'assets/icons/mark.svg',
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: Colors.white54,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            list[index].nama,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Text(
                                            list[index].alamat,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                      CircleIconButton(
                                          iconUrl: 'assets/icons/mark.svg',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (_, index) => const SizedBox(width: 20),
                  itemCount: list.length),
            );
          }
          return Container();
        });
  }
}
