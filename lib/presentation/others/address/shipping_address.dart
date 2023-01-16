import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/presentation/others/google_maps.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Shipping Address'),
            SizedBox(
              height: 30,
              child: Image.asset("assets/cart/location-pin.png"),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          TextFormField(
            cursorColor: primaryBackgroundColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              hintText: 'Full Name',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          ksizedBoxheight10,
          TextFormField(
            cursorColor: primaryBackgroundColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.call),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              hintText: 'Phone Number',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          ksizedBoxheight10,
          TextFormField(
            maxLines: 5,
            cursorColor: primaryBackgroundColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              suffixIconColor: primaryFontColor,
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(),
              suffixIcon: const Icon(Icons.location_on),
              hintText: 'Address',
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ScreenGoogleMaps(),
                ),
              );
            },
            icon: const Icon(
              Icons.location_on,
            ),
            label: const Text('Pick Your Address'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              fixedSize: Size(MediaQuery.of(context).size.width / 2.5, 50),
              backgroundColor: primaryBackgroundColor,
              // padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ShippingAddress(),
              ));
            },
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
