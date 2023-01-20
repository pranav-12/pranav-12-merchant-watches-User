import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
        items: List.generate(value.length, (index) {
          return Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: primaryBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                fit: BoxFit.contain,
                image: NetworkImage(value[index]!.image![0]!),
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
