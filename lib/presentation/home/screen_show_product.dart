import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/product_details_provider/product_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/products_model.dart';
import 'package:merchant_watches/presentation/others/checkout.dart';
import 'package:provider/provider.dart';

import '../../constants/list.dart';

class ScreenShowProductDetails extends StatelessWidget {
  final Product product;
  ScreenShowProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
// appbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(12), children: [
// sized Box for that contains the top images
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height / 2.5,
          child: Consumer<ProductDetailsProvider>(
            builder: (context, value, child) =>
                Image.network(product.image![value.imgList]!),
          ),
        ),
        ksizedBoxheight10,
// container for each photo every angle
        Container(
          height: size.width / 6,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(15)),
          child: Consumer<ProductDetailsProvider>(
            builder: (context, value, child) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                growable: true,
                4,
                (index1) => Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: InkWell(
                    onTap: () {
                      value.changeImage(index1);
                    },
                    child: Image.network(product.image![index1]!),
                  ),
                ),
              ),
            ),
          ),
        ),
        ksizedBoxheight20,
// row for showing the title and color of the watches
        Text(
          product.name!,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        ksizedBoxheight10,
// text for description for the watch
        Text(
          product.description!,
          // maxLines: 5,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        ksizedBoxheight20,
// rate for watch
        Text(
          "₹ ${product.price}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ksizedBoxheight10,
// container contains the full section of the qty
        Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Qty : ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () =>
                    Provider.of<ProductDetailsProvider>(context, listen: false)
                        .addSubtractQtyFunc(false),
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Consumer<ProductDetailsProvider>(
                builder: (context, value, child) => Text(value.qty.toString()),
              ),
              IconButton(
                onPressed: () =>
                    Provider.of<ProductDetailsProvider>(context, listen: false)
                        .addSubtractQtyFunc(true),
                icon: const Icon(Icons.add_circle_outline_outlined),
              ),
            ],
          ),
        ),
        ksizedBoxheight20,
// Row for addtoCart and Buy buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(size.width / 2.5, 50),
                backgroundColor: primaryBackgroundColor,
                // padding: const EdgeInsets.all(15),
              ),
              onPressed: () {},
              child: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(size.width / 2.5, 50),
                backgroundColor: primaryBackgroundColor,
                // padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CheckoutScreen(),
                ));
              },
              child: const Text(
                'Buy',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        // ksizedBoxheight20,
        // const Text(
        //   'Overview',
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        // ),
        // ksizedBoxheight20,
        // ListView.separated(
        //   shrinkWrap: true,
        //   physics: const ScrollPhysics(),
        //   itemBuilder: (context, index) => Container(
        //     decoration: BoxDecoration(color: cartImageColor),
        //     child: Image.network(overView[index]),
        //   ),
        //   separatorBuilder: (context, index) => const SizedBox(
        //     height: 10,
        //   ),
        //   itemCount: overView.length,
        // )
      ]),
    );
  }
}
