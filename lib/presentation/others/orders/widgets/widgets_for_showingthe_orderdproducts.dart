
import 'package:flutter/material.dart';

import '../../../../domain/models/order_model.dart';

class WidgetsForShowtheOrderedProducts extends StatelessWidget {
  const WidgetsForShowtheOrderedProducts({
    super.key,
    required this.order,
    required this.size,
  });

  final Order order;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        reverse: true,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final product =
              order.products![index]!.product!;
          return Container(
            padding: const EdgeInsets.all(10),
            height: size.width * 0.3,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.2,
                  child: Image.network(
                      product.image![0]!),
                ),
                // ksizedBoxWidth10,
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.66,
                      child: Text(
                        product.name!,
                        style: const TextStyle(
                            overflow:
                                TextOverflow.ellipsis,
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    // ksizedBoxheight10,
                    SizedBox(
                      width: size.width * 0.66,
                      child: Text(
                          product.description!,
                          overflow:
                              TextOverflow.ellipsis,
                          maxLines: 3),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: order.products!.reversed.length);
  }
}
