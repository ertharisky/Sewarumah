import 'package:flutter/material.dart';
import 'package:sewarumah/model/ad.dart';
import 'package:sewarumah/screen/detail/widget/about.dart';
import 'package:sewarumah/screen/detail/widget/content_intro.dart';
import 'package:sewarumah/screen/detail/widget/detail_app_bar.dart';

class DetailTransactionPage extends StatelessWidget {
  final ModelAd house;
  const DetailTransactionPage({Key? key, required this.house})
      : super(key: key);

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
          About(
            house: house,
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      )),
    );
  }
}
