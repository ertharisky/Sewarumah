import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HouseInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: const [
              MenuInfo(
                  imageUrl: 'assets/icons/bedroom.svg',
                  content: '5 Bedroom\n3 Master Bedroom'),
              MenuInfo(
                  imageUrl: 'assets/icons/bathroom.svg',
                  content: '5 Bathroom\n3 Toilet'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              MenuInfo(
                  imageUrl: 'assets/icons/kitchen.svg',
                  content: '2 Bedroom\n120 m2'),
              MenuInfo(
                  imageUrl: 'assets/icons/parking.svg',
                  content: '2 Parking\n120 m2'),
            ],
          )
        ],
      ),
    );
  }
}

class MenuInfo extends StatelessWidget {
  final String imageUrl;
  final String content;
  const MenuInfo({Key? key, required this.imageUrl, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SvgPicture.asset(imageUrl),
          const SizedBox(width: 20),
          Text(
            content,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }
}
