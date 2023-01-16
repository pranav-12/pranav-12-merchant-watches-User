import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/home/home_provider.dart';
import 'package:merchant_watches/presentation/widgets/loading_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';

class CarouselForImage extends StatelessWidget {
  const CarouselForImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: productDataList,
      builder: (context, value, child) => CarouselSlider(
        items: [
          for (int i = 0; i < value.length; i++)
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.fill,
                  image: NetworkImage(value[i]["image"][0]),
                ),
              ),
            ),
        ],
        options: CarouselOptions(
            height: 200,
            autoPlay: true,
            animateToClosest: true,
            enlargeCenterPage: true,
            enlargeFactor: 0.2),
      ),
    );
  }
}
