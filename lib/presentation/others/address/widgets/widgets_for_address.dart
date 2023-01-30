
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../appication/other/address_provider.dart';
import '../../../../domain/models/address_model.dart';
import '../shipping_address.dart';

class ContainerWidgetForShowtingtheAddress extends StatelessWidget {
  const ContainerWidgetForShowtingtheAddress({
    super.key,
    required this.addressData,
    required this.addressList,
    required this.index,
  });
  final List<Address?> addressList;
  final Address? addressData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.28,
      // width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Radio(
            activeColor: Colors.green,
            value: addressList[index],
            groupValue: Provider.of<AddressProvider>(
                  context,
                ).address ??
                addressList[0],
            onChanged: (value) {
              Provider.of<AddressProvider>(context, listen: false)
                  .valueForRadioButton(addressList[index]!);
            },
          ),
          Expanded(
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
                      builder: (context, addressprov, child) => GestureDetector(
                        onTap: () =>
                            addressprov.deleteAddress(addressData!, context),
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    'Address : ${addressData!.address}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
                Text('Place : ${addressData!.place}'),
                Text('State : ${addressData!.state}'),
                Text('PIN : ${addressData!.pin}'),
                Text('Phone : ${addressData!.phone}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Class For Mention the Address And AddAddress
class WidgetsForMentiontheAddressAndAddAddress extends StatelessWidget {
  const WidgetsForMentiontheAddressAndAddAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
