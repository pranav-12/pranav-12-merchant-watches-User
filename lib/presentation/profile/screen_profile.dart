import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/profile/profile_provider.dart';
import 'package:merchant_watches/presentation/others/orders/order.dart';
import 'package:merchant_watches/presentation/profile/widgets/widget_for_address_details.dart';
import 'package:merchant_watches/presentation/profile/widgets/widgets_for_information_details.dart';
import 'package:merchant_watches/presentation/profile/widgets/widgets_for_logout_button.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).sharedpreferen();
    final size = MediaQuery.of(context).size;
    return Scaffold(
// Appbar
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: const Text('Profile'),
      ),
// Body
      body: ListView(
        children: [
          ksizedBoxWidth20,
          Padding(
            padding: const EdgeInsets.all(5),
            child: ValueListenableBuilder(
              valueListenable: addressDataList,
              builder: (context, value, child) {
                final addressDetails = value.first;
                return WidgetForUserAddressDetailsAndAddAddress(
                    size: size, addressDetails: addressDetails);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account Settings',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                    ListTile(
                      minLeadingWidth: size.width * 0.1,
                      leading: SizedBox(
                        height: size.height * 0.1,
                        width: size.width * 0.1,
                        child: Image.asset(
                          "assets/order.png",
                        ),
                      ),
                      title: const Text('Your Orders'),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ScreenOrders(),
                          ));
                        },
                        icon: const Icon(CupertinoIcons.chevron_forward),
                      ),
                    ),
                    ksizedBoxheight10
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5),
            child: WidgetForInformation(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WidgetForLogOutBurtton(size: size),
          ),
          ksizedBoxheight20
        ],
      ),
    );
  }
}
