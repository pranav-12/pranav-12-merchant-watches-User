import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../appication/product_details_provider/product_provider.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// Appbar
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('My Cart'),
            SizedBox(height: 40, child: Image.asset("assets/cart/bag.png"))
          ],
        ),
      ),
// body
      body: ListView(children: [
        ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) =>
// Container contains of the cart details
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  height: MediaQuery.of(context).size.height / 5,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
// Row Contains the images and remove icon
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: cartImageColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.network(
                                    "https://cdn.shopify.com/s/files/1/0997/6284/products/Side04.png?v=1671685358"
                                    // imagevariation[index]
                                    ),
                              ),
                              const Icon(
                                CupertinoIcons.clear_circled_solid,
                                size: 30,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          ksizedBoxWidth10,
// Expanded the full details about the cart
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
// Row contains the Brand Name and WishList icon
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Rollex',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.favorite_border))
                                  ],
                                ),
// The Text for Color of the watch
                                const Text(
                                  'Color',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
// row Contains the Rate and qty of the Watch
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "₹2344",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () => Provider.of<
                                                        ProductDetailsProvider>(
                                                    context,
                                                    listen: false)
                                                .addSubtractQtyFunc(false),
                                            icon: const Icon(
                                                Icons.remove_circle_outline),
                                          ),
                                          Consumer<ProductDetailsProvider>(
                                            builder: (context, value, child) =>
                                                Text(value.qty.toString()),
                                          ),
                                          IconButton(
                                            onPressed: () => Provider.of<
                                                        ProductDetailsProvider>(
                                                    context,
                                                    listen: false)
                                                .addSubtractQtyFunc(true),
                                            icon: const Icon(Icons
                                                .add_circle_outline_outlined),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
            itemCount: 4),
// Divider for separation
        Divider(
          thickness: 1,
          color: primaryBackgroundColor,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Order Summery',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.red, width: 2),
            ),
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Total Quantity :',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '4',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                ksizedBoxheight20,
                Divider(
                  thickness: 1,
                  color: primaryBackgroundColor,
                ),
                ksizedBoxheight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      overflow: TextOverflow.visible,
                      'Total Amount :',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '₹12000',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Payment Via',
            style: TextStyle(fontSize: 20),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.red, width: 2),
            ),
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width / 1.5, 50),
                    backgroundColor: primaryBackgroundColor,
                    // padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Cash On Delivery',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ksizedBoxheight10,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width / 1.5, 50),
                    backgroundColor: primaryBackgroundColor,
                    // padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Card or UPI',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
