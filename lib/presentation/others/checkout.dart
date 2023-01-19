import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/address/address_provider.dart';
import 'package:merchant_watches/presentation/others/address/shipping_address.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';

enum PaymentMethodForPlaceOrder { cashOnDelivery, card }

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AddressProvider>(context, listen: false).getDataFromAddres();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Checkout'),
            SizedBox(
              height: 30,
              child: Image.asset("assets/cart/shopping.png"),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Shipping Address',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const ShippingAddress(type: ActionType.addAddress),
                      )),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Address'))
            ],
          ),
          ksizedBoxheight10,
          ValueListenableBuilder(
            valueListenable: addressDataList,
            builder: (context, addressList, child) => ListView.separated(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final addressData = addressList[index];
                  return GestureDetector(
                    onLongPress: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShippingAddress(
                          type: ActionType.updateAddress,
                          id: addressData.id,
                          address: addressData),
                    )),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.26,
                      // width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: cartImageColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ADDRESS - ${index + 1}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Consumer<AddressProvider>(
                                builder: (context, addressprov, child) =>
                                    GestureDetector(
                                  onTap: () =>
                                      addressprov.deleteAddress(addressData!,context),
                                  child: const Icon(
                                    CupertinoIcons.xmark_rectangle_fill,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            "Name : ${addressData!.fullName}",
                          ),
                          Text(
                            'Address : ${addressData.address}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                          Text('Place : ${addressData.place}'),
                          Text('State : ${addressData.state}'),
                          Text('PIN : ${addressData.pin}'),
                          Text('Phone : ${addressData.phone}'),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: addressList.length),
          ),
          ksizedBoxheight20,
          const Text(
            'Payment Method',
            style: TextStyle(fontSize: 16),
          ),
          ksizedBoxheight10,
          Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio(
                      value: PaymentMethodForPlaceOrder,
                      groupValue: PaymentMethodForPlaceOrder,
                      onChanged: (value) {},
                    ),
                    const Text(
                      'Cash On Delivery',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                ksizedBoxheight10,
                Row(
                  children: [
                    Radio(
                      value: PaymentMethodForPlaceOrder.cashOnDelivery,
                      groupValue: PaymentMethodForPlaceOrder,
                      onChanged: (value) {},
                    ),
                    const Text(
                      'Card',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ksizedBoxheight20,
          ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => ShippingAddress(),
                // ));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(MediaQuery.of(context).size.width / 2.5, 50),
                backgroundColor: primaryBackgroundColor,
                // padding: const EdgeInsets.all(15),
              ),
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
