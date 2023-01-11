import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/product_details_provider/product_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/presentation/others/checkout.dart';
import 'package:provider/provider.dart';

import '../../constants/list.dart';

class ScreenShowProductDetails extends StatelessWidget {
  const ScreenShowProductDetails({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () => context.read<ProductDetailsProvider>().initState(imagevariation),
    );
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
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Row(
            children: [
// coloum for selecting the colors sections
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  growable: true,
                  listColors.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<ProductDetailsProvider>(
                      builder: (context, value, child) => InkWell(
                        onTap: () {
                          value.initState(allImages[index]);
                        },
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: listColors[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ksizedBoxWidth20,
// this for showing the top images of the page
              Consumer<ProductDetailsProvider>(
                builder: (context, value, child) => Image.network(
                    "https://cdn.shopify.com/s/files/1/0997/6284/products/Side04.png?v=1671685358"
                    // value.imageAllvariation[value.imgList]
                    ),
              ),
            ],
          ),
        ),
        ksizedBoxheight50,
// container for each photo every angle
        Container(
          height: size.width / 6,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Consumer<ProductDetailsProvider>(
            builder: (context, value, child) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                growable: true,
                value.imageAllvariation.length,
                (index) => Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: InkWell(
                      onTap: () {
                        value.changeImage(index);
                      },
                      child: Image.network(
                          "https://cdn.shopify.com/s/files/1/0997/6284/products/Side04.png?v=1671685358"
                          // value.imageAllvariation[index]
                          )),
                ),
              ),
            ),
          ),
        ),
        ksizedBoxheight20,
// row for showing the title and color of the watches
        Row(
          children: const [
            Text(
              'Color Fit Pulse Grand',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              ' - Jet Black',
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
        ksizedBoxheight10,
// text for description for the watch
        const Text(
          "CONNECTIVITYSystem Requirement : iOS 8.0 &  or Android 6.0 & BT : v5.3 , Display technology : TFT ,Size : 1.28 ,Resolution : 240*240,Brightness : 500 nits,Cloud-based watch faces : Yes,Typical Usage Time : 7 days,Standby Time : 25 days,Capacity : 290mAh,Charging Time : Up to 2.5 hours,Charging Cable : Yes",
          maxLines: 5,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        ksizedBoxheight20,
// rate for watch
        const Text(
          "₹2999",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  builder: (context) => CheckoutScreen(),
                ));
              },
              child: const Text(
                'Buy',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        ksizedBoxheight20,
        const Text(
          'Overview',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        ksizedBoxheight20,
        ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(color: cartImageColor),
            child: Image.network(overView[index]),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: overView.length,
        )
      ]),
    );
  }
}
