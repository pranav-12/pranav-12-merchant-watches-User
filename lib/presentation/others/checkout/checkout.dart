import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/address/address_provider.dart';
import 'package:merchant_watches/domain/models/address_model.dart';
import 'package:merchant_watches/domain/models/products_model.dart';
import 'package:merchant_watches/presentation/others/address/shipping_address.dart';
import 'package:merchant_watches/presentation/others/checkout/cashondelivery.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../widgets/custom_button.dart';

class CheckoutScreen extends StatelessWidget {
  final Product product;
  const CheckoutScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddressProvider>(context, listen: false).getDataFromAddres();
      Provider.of<AddressProvider>(context, listen: false).address = null;
      Provider.of<AddressProvider>(context, listen: false)
          .showSaveButtonFunc(true);
    });
    log("address checking---------------------%%%%%${Provider.of<AddressProvider>(context, listen: false).address}");
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
                label: const Text('Add Address'),
              )
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
                    onTap: () {
                      Provider.of<AddressProvider>(context, listen: false)
                          .valueForRadioButton(addressList[index]!);
                      // final cart = data[index];
                      final varial = addressList.firstWhere(
                          (element) => element == addressList[index]);
                      log(varial!.fullName.toString());
                      Provider.of<AddressProvider>(context, listen: false)
                          .isSelected();
                    },
                    onLongPress: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShippingAddress(
                          type: ActionType.updateAddress,
                          id: addressData.id,
                          address: addressData),
                    )),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.28,
                      // width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        color: cartImageColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Radio(
                            activeColor: Colors.green,
                            value: addressList[index],
                            groupValue: Provider.of<AddressProvider>(
                              context,
                            ).address,
                            onChanged: (value) {
                              Provider.of<AddressProvider>(context,
                                      listen: false)
                                  .valueForRadioButton(addressList[index]!);
                            },
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "ADDRESS - ${index + 1}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Consumer<AddressProvider>(
                                      builder: (context, addressprov, child) =>
                                          GestureDetector(
                                        onTap: () => addressprov.deleteAddress(
                                            addressData!, context),
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    'Address : ${addressData.address}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                  ),
                                ),
                                Text('Place : ${addressData.place}'),
                                Text('State : ${addressData.state}'),
                                Text('PIN : ${addressData.pin}'),
                                Text('Phone : ${addressData.phone}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(color: primaryBackgroundColor),
                itemCount: addressList.length),
          ),
          ksizedBoxheight20,
          Consumer<AddressProvider>(
            builder: (context, value, child) {
              log(value.showSaveButton.toString());
              return Visibility(
                visible: value.showSaveButton,
                child: const Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 16),
                ),
              );
            },
          ),
          ksizedBoxheight10,
          Consumer<AddressProvider>(
            builder: (context, addressProvider, child) => Visibility(
              visible: addressProvider.showSaveButton,
              replacement: CustomElevatedButton(
                  function: () {
                    cashOnDelivery(
                        addressProvider, context, addressProvider.address);
                  },
                  title: "Save"),
              child: Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Consumer<AddressProvider>(
                  builder: (context, addresPro, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                        function: () {
                          cashOnDelivery(addresPro, context, addresPro.address);
                        },
                        title: "Cash On Delivery",
                      ),
                      ksizedBoxheight10,
                      CustomElevatedButton(
                        function: () {},
                        title: "Debit/Credit Cards",
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          ksizedBoxheight20,
        ],
      ),
    );
  }

  void cashOnDelivery(
      AddressProvider addressProvider, BuildContext context, Address? address) {
    log(address.toString());
    if (address == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: const Text("Invalid Address"),
        ),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ScreenCashOnDelivery(
          address: address,
          product: product,
        ),
      ),
    );
  }
}
