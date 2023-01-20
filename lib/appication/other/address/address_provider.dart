import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/domain/models/address_model.dart';
import 'package:merchant_watches/infrastructure/others/address/address_servises.dart';
import 'package:merchant_watches/presentation/others/address/shipping_address.dart';

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

  void showSaveButtonFunc(bool val) {
    showSaveButton = val;
    notifyListeners();
  }

  void valueForRadioButton(Address add) {
    address = add;
    notifyListeners();
  }

  bool isSelected() {
    bool addressSelectionBool = false;
    addressSelectionBool = !addressSelectionBool;

    return addressSelectionBool;
  }

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
            // id: DateTime.now().microsecondsSinceEpoch.toString(),
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

  void deleteAddress(Address address, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 10,
        dismissDirection: DismissDirection.horizontal,
        action: SnackBarAction(
          label: "Yes",
          textColor: Colors.black,
          onPressed: () async {
            try {
              Response? response =
                  await AddressServices().deleteAddress(address);
              await AddressServices().getAllAddress();
              if (response == null) {
                log("!!!!!!!!!!responsel  $response");
              }
              if (response!.statusCode == 202) {}
              log(response.toString());
            } catch (e) {
              log(e.toString());
            }
          },
        ),
        behavior: SnackBarBehavior.floating,
        // duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.red,
        content: const Text('Do you want to delete'),
      ),
    );

    notifyListeners();
  }

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
}
