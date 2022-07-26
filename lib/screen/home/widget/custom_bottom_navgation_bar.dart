import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sewarumah/screen/home/home_page.dart';
import 'package:sewarumah/screen/home/widget/my_ad.dart';
import 'package:sewarumah/screen/transaction_history.dart';

class CustomBottomNavigationBar extends StatelessWidget {
// final bottomBarItem = [{'home', HomePage()}, 'notification', 'home_mark'];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 25),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            child: SvgPicture.asset(
              'assets/icons/home.svg',
              color: Theme.of(context).primaryColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyAdPage(),
                ),
              );
            },
            child: SvgPicture.asset(
              'assets/icons/notification.svg',
              color: Theme.of(context).primaryColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionHistory(),
                ),
              );
            },
            child: SvgPicture.asset(
              'assets/icons/home_mark.svg',
              color: Theme.of(context).primaryColor,
            ),
          ),
        ]));
  }
}
