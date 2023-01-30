import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/address_model.dart';
import 'package:merchant_watches/infrastructure/others/address/address_servises.dart';
import 'package:merchant_watches/presentation/others/address/shipping_address.dart';

import '../../presentation/others/checkout/checkout.dart';

class AddressProvider with ChangeNotifier {
  final formKeyForAddress = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final placeController = TextEditingController();
  final pinController = TextEditingController();
  Address? address;
  bool showSaveButton = true;

// For Enabling or show the Save Button
  void showSaveButtonFunc(bool val) {
    showSaveButton = val;
    notifyListeners();
  }

// For Assign the Value For RadioButton
  void valueForRadioButton(Address add) {
    address = add;
    notifyListeners();
  }

// For Selecting the Address For Purchase
  bool isSelected() {
    bool addressSelectionBool = false;
    addressSelectionBool = !addressSelectionBool;
    return addressSelectionBool;
  }

// For submit the Address that led to CheckOUtScreen
  void submitButtonForAddress(
      {required BuildContext context,
      required ActionType type,
      Address? address}) async {
    if (fullNameController.text.isEmpty &&
        phoneController.text.isEmpty &&
        addressController.text.isEmpty &&
        placeController.text.isEmpty &&
        stateController.text.isEmpty &&
        pinController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid details'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        ),
      );
      notifyListeners();
    } else {
      if (formKeyForAddress.currentState!.validate()) {
        if (type == ActionType.addAddress) {
          final addAddress = Address(
            userId: userId,
            fullName: fullNameController.text,
            phone: phoneController.text,
            address: addressController.text,
            place: placeController.text,
            state: stateController.text,
            pin: pinController.text,
          );
          Response? response = await AddressServices().addAddress(addAddress);
          await AddressServices().getAllAddress();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor:
                  response!.statusCode == 201 ? Colors.green : Colors.red,
              content: response.statusCode == 201
                  ? const Text("Address Added SuccessFully")
                  : const Text("All fields are Required"),
              behavior: SnackBarBehavior.floating,
            ),
          );
          if (response.statusCode == 201) {
            fullNameController.clear();
            phoneController.clear();
            addressController.clear();
            stateController.clear();
            placeController.clear();
            pinController.clear();
            Navigator.of(context).pop();
          }
          log(response.statusMessage.toString());
        } else {
          try {
            final updateAddress = Address(
                id: address!.id,
                fullName: fullNameController.text,
                address: addressController.text,
                phone: phoneController.text,
                pin: pinController.text,
                place: placeController.text,
                state: stateController.text,
                userId: address.userId);
            Response? response =
                await AddressServices().upDateAddress(updateAddress);
            await AddressServices().getAllAddress();
            if (response!.statusCode == 202) {
              fullNameController.clear();
              phoneController.clear();
              addressController.clear();
              stateController.clear();
              placeController.clear();
              pinController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor:
                      response.statusCode == 202 ? Colors.green : Colors.red,
                  content: response.statusCode == 202
                      ? const Text("Address Updated SuccessFully")
                      : const Text("All fields are Required"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.of(context).pop();
            }
            log(response.statusMessage.toString());

            log("response in provider :----$response");
          } catch (e) {
            log("e in updateProvider :----$e");
          }
        }
      }
      notifyListeners();
    }
  }

// For Deleting the Address
  void deleteAddress(Address address, BuildContext context) {
    showBottomSheet(
      backgroundColor: cartImageColor,
      enableDrag: true,
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        child: Column(
          children: [
            const Text(
              'Do you want to delete?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ksizedBoxheight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.clear)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: IconButton(
                      onPressed: () async {
                        try {
                          Response? response =
                              await AddressServices().deleteAddress(address);
                          await AddressServices().getAllAddress();
                          if (response == null) {
                            log("!!!!!!!!!!responsel  $response");
                          }
                          log(response.toString());
                        } catch (e) {
                          log(e.toString());
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            content: const Text(
                              "Product deleted Successfully",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.check)),
                )
              ],
            )
          ],
        ),
      ),
    );
    notifyListeners();
  }

// For Getting Address Data From Api's
  void getDataFromAddres() async {
    try {
      Response? response = await AddressServices().getAllAddress();
      if (response == null) {
        log("*-*-*-*--*-data is null");
      }
      if (response!.statusCode == 200) {}
      log(response.toString());
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

// For Proceed the Address Section Using in ElevatedButton
  void proceedButton(
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
        builder: (context) => ScreenCheckOut(
          address: address,
        ),
      ),
    );
  }
}
