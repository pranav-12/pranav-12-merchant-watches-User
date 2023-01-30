import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/profile/profile_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../domain/models/address_model.dart';
import '../../others/address/shipping_address.dart';

class WidgetForUserAddressDetailsAndAddAddress extends StatelessWidget {
  const WidgetForUserAddressDetailsAndAddAddress({
    super.key,
    required this.size,
    required this.addressDetails,
  });

  final Size size;
  final Address? addressDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: size.width * 0.6,
        // decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'User Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                GestureDetector(
                    onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ShippingAddress(
                                type: ActionType.addAddress),
                          ),
                        ),
                    child: const Icon(Icons.edit, size: 28))
              ],
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ksizedBoxheight10,
                  Text(
                    "Name : ${addressDetails!.fullName}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: Text(
                      'Address : ${addressDetails!.address} ${addressDetails!.place} ${addressDetails!.state} ${addressDetails!.pin}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                  ),
                  Text(
                    'Phone : ${addressDetails!.phone}',
                    style: const TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                  Text(
                    'E-mail : ${Provider.of<ProfileProvider>(context).email}',
                    style: const TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                  ksizedBoxheight10,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
