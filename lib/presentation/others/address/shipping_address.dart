import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant_watches/appication/other/address_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/address_model.dart';
import 'package:merchant_watches/infrastructure/others/address/address_servises.dart';
import 'package:merchant_watches/presentation/widgets/textformfield_.dart';
import 'package:provider/provider.dart';

enum ActionType {
  addAddress,
  updateAddress,
}

class ShippingAddress extends StatelessWidget {
  final String? id;
  final ActionType type;
  final Address? address;

  const ShippingAddress({super.key, required this.type, this.id, this.address});

  @override
  Widget build(BuildContext context) {
    if (type == ActionType.updateAddress) {
      log("id##########  $id");
      if (id == null) {
        Navigator.of(context).pop();
      }
      final address = AddressServices().getNoteByID(id!);
      // final address = addressDataList.value[index!];
      if (address == null) {
        Navigator.of(context).pop();
      }

      final addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      addressProvider.fullNameController.text = address!.fullName ?? "No Name";
      addressProvider.addressController.text = address.address ?? "No Address";
      addressProvider.phoneController.text = address.phone ?? "No phone";
      addressProvider.stateController.text = address.state ?? "No state";
      addressProvider.placeController.text = address.place ?? "No place";
      addressProvider.pinController.text = address.pin ?? "No pin";
    } else {
      final addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      addressProvider.fullNameController.clear();
      addressProvider.addressController.clear();
      addressProvider.phoneController.clear();
      addressProvider.stateController.clear();
      addressProvider.placeController.clear();
      addressProvider.pinController.clear();
    }
    // log(index.toString());
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
      body: Consumer<AddressProvider>(
        builder: (context, addProv, child) {
          return Form(
            key: addProv.formKeyForAddress,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                TextFormFieldForAddressing(
                  controller: addProv.fullNameController,
                  hintText: 'Full Name',
                  maxLength: 20,
                  formator: [
                    FilteringTextInputFormatter(RegExp("[a-zA-Z ]"),
                        allow: true)
                  ],
                  icons: const Icon(Icons.person),
                  keyBoardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid name';
                    } else if (value.length < 3) {
                      return 'Minimum 3 letters';
                    }
                    return null;
                  },
                ),
                TextFormFieldForAddressing(
                  controller: addProv.addressController,
                  maxLength: 90,
                  hintText: 'Address',
                  maxLines: 2,
                  icons: const Icon(Icons.location_on),
                  keyBoardType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid Address';
                    }
                    return null;
                  },
                ),
                TextFormFieldForAddressing(
                  controller: addProv.placeController,
                  hintText: 'Place',
                  maxLength: 20,
                  keyBoardType: TextInputType.streetAddress,
                  formator: [
                    FilteringTextInputFormatter(RegExp("[a-zA-Z ]"),
                        allow: true)
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid Place';
                    }
                    return null;
                  },
                ),
                TextFormFieldForAddressing(
                  controller: addProv.stateController,
                  hintText: 'State',
                  maxLength: 20,
                  keyBoardType: TextInputType.streetAddress,
                  formator: [
                    FilteringTextInputFormatter(RegExp("[a-zA-Z ]"),
                        allow: true)
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid State';
                    }
                    return null;
                  },
                ),
                TextFormFieldForAddressing(
                  controller: addProv.pinController,
                  maxLength: 6,
                  hintText: 'PIN',
                  keyBoardType: TextInputType.number,
                  formator: [
                    FilteringTextInputFormatter(RegExp("[0-9]"), allow: true)
                  ],
                  validator: (value) {
                    if (value!.isEmpty || value.length != 6) {
                      return 'Invalid PIN';
                    }
                    return null;
                  },
                ),
                TextFormFieldForAddressing(
                  controller: addProv.phoneController,
                  hintText: 'Phone',
                  formator: [
                    FilteringTextInputFormatter(RegExp("[0-9]"), allow: true)
                  ],
                  icons: const Icon(Icons.call),
                  keyBoardType: TextInputType.number,
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty || value.length != 10) {
                      return 'Invalid Phonenumber';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width / 2.5, 50),
                    backgroundColor: primaryBackgroundColor,
                  ),
                  onPressed: () {
                    addProv.submitButtonForAddress(
                        context: context, type: type, address: address);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
