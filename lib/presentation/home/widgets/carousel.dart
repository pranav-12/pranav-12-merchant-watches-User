import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/core/listfor_banners.dart';
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
        items: List.generate(ListForbanners().banners.length, (index) {
          return Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: primaryBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                fit: BoxFit.contain,
                image: AssetImage(ListForbanners().banners[index]),
              ),
            ),
          );
        }),
        options: CarouselOptions(
          enableInfiniteScroll: true,
          height: 200,
          autoPlay: true,
          // reverse: true,
          animateToClosest: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,

          enlargeFactor: 0.2,
        ),
      ),
    );
  }
}
