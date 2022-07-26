import 'package:flutter/material.dart';
import 'package:sewarumah/screen/home/widget/best_offer.dart';
import 'package:sewarumah/screen/home/widget/categories.dart';
import 'package:sewarumah/screen/home/widget/custom_app_bar.dart';
import 'package:sewarumah/screen/home/widget/custom_bottom_navgation_bar.dart';
import 'package:sewarumah/screen/home/widget/recommended_house.dart';
import 'package:sewarumah/screen/home/widget/search_input.dart';
import 'package:sewarumah/screen/home/widget/welcome_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeText(),
            SearchInput(),
            Categories(),
            RecommendedHouse(),
            BestOffer(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
