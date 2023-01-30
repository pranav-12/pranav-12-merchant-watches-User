import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/other/address_provider.dart';
import 'package:merchant_watches/domain/models/address_model.dart';
import 'package:merchant_watches/presentation/others/address/shipping_address.dart';
import 'package:merchant_watches/presentation/others/address/widgets/widgets_for_address.dart';
import 'package:merchant_watches/presentation/others/checkout/checkout.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../widgets/custom_button.dart';

class ScreenAddress extends StatelessWidget {
  const ScreenAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddressProvider>(context, listen: false).getDataFromAddres();
      Provider.of<AddressProvider>(context, listen: false).address;
      Provider.of<AddressProvider>(context, listen: false)
          .showSaveButtonFunc(true);
    });
    return Scaffold(
// Appbar
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Address'),
            SizedBox(
              height: 30,
              child: Image.asset("assets/pin.png"),
            )
          ],
        ),
      ),
// Body
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
// For Showing Address
          const WidgetsForMentiontheAddressAndAddAddress(),
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
                      final varial = addressList.firstWhere(
                          (element) => element == addressList[index]);
                      log(varial!.fullName.toString());
                      Provider.of<AddressProvider>(context, listen: false)
                          .isSelected();
                    },
                    onLongPress: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ShippingAddress(
                            type: ActionType.updateAddress,
                            id: addressData!.id,
                            address: addressData),
                      ),
                    ),
// For Showing the Address
                    child: ContainerWidgetForShowtingtheAddress(
                        addressList: addressList,
                        index: index,
                        addressData: addressData),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(color: primaryBackgroundColor),
                itemCount: addressList.length),
          ),
          ksizedBoxheight20,
          Consumer<AddressProvider>(
            builder: (context, addressProvider, child) => Visibility(
              visible: addressProvider.showSaveButton,
              replacement: CustomElevatedButton(
                  function: () {
                    addressProvider.proceedButton(
                        addressProvider, context, addressProvider.address);
                  },
                  title: "Save",
                  color: Colors.indigo),
              child: Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.width * 0.25,
                // width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Consumer<AddressProvider>(
                  builder: (context, addresPro, child) => CustomElevatedButton(
                    function: () {
                      addresPro.proceedButton(
                          addresPro, context, addresPro.address);
                    },
                    color: Colors.indigo,
                    title: "Proceed",
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
}
