import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import '../../../domain/models/products_model.dart';
import '../../../infrastructure/cart/cart_service.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({super.key, this.index, this.product});
  final Product? product;
  final int? index;

  @override
  Widget build(BuildContext context) {
    log(index.toString());
    return SizedBox(
// For Value Listnable builder is Generate the Cart Data's As a List
      child: ValueListenableBuilder(
        valueListenable: cartDataList,
        builder: (context, cart, child) {
          final cartData = cart[index!]!.product;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cart[index!]!.qty! > 1
                  ? IconButton(
                      onPressed: () async {
                        await CartService().addToCart(cartData!, context, -1);
                        await CartService().getDataCart(context);
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                    )
                  : const SizedBox(),
              Text(cart[index!]!.qty!.toString()),
              IconButton(
                onPressed: () async {
                  await CartService().addToCart(cartData!, context, 1);
                  await CartService().getDataCart(context);
                },
                icon: const Icon(Icons.add_circle_outline_outlined),
              ),
            ],
          );
        },
      ),
    );
  }
}
