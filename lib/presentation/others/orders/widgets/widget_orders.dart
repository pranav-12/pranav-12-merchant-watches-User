import 'package:flutter/material.dart';
import 'package:merchant_watches/domain/models/order_model.dart';
import 'package:provider/provider.dart';
import '../../../../appication/other/orders_provider.dart';
import '../../../../constants/constants.dart';

class WidgetsForOrder extends StatelessWidget {
  const WidgetsForOrder({Key? key, this.size, this.orders}) : super(key: key);
  final Order? orders;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: size!.width * 0.7,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Address',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
          Consumer<OrderProvider>(
            builder: (context, orderProv, child) {
              final address = orders;
              return SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ksizedBoxheight10,
// For Name
                    Text(
                      "Name : ${address!.fullName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
// For Address
                    SizedBox(
                      width: size!.width * 0.7,
                      child: Text(
                        'Address : ${address.address}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ),
// For Place
                    Text(
                      'Place : ${address.place}',
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
// For State
                    Text(
                      'State : ${address.state}',
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
// For pin
                    Text(
                      'PIN : ${address.pin}',
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
// For phone
                    Text(
                      'Phone : ${address.phone}',
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    ksizedBoxheight10,
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

// For This Container Widget returns the Details of Order
  Container orderDetailsContainer(
      {required Size size, required String id, required BuildContext context}) {
    final orderDetails = Provider.of<OrderProvider>(context, listen: false)
        .findIdForGettingOrders(id);
    return Container(
      padding: const EdgeInsets.all(10),
      height: size.width * 0.63,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
// Row contains the OrderId
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order Id',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                orderDetails.id.toString(),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          ksizedBoxheight10,
// Row contains the either Delivery Date and Cancel date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderDetails.orderStatus == 'confirmed'
                    ? 'Delivery Date'
                    : 'Cancel Date',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                orderDetails.orderStatus == 'confirmed'
                    ? Provider.of<OrderProvider>(context, listen: false)
                        .dateTime(
                        orderDetails.deliveryDate!,
                      )
                    : Provider.of<OrderProvider>(context, listen: false)
                        .dateTime(
                        orderDetails.cancelDate!,
                      ),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          ksizedBoxheight10,
// Row contains the OrderDate
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                Provider.of<OrderProvider>(context, listen: false).dateTime(
                  orderDetails.orderDate,
                ),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          ksizedBoxheight10,
// Row contains the Payment Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payment Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                orderDetails.paymentType == 'ONLINE_PAYMENT'
                    ? 'Paid'
                    : 'Pending',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          ksizedBoxheight10,
// Row contains the Order Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                orderDetails.orderStatus.toString(),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          ksizedBoxheight10,
// Row contains the Payment Type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payment Type',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                orderDetails.paymentType.toString(),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          ksizedBoxheight10,
        ],
      ),
    );
  }

// For this ContainerFuction For Show the PaymentsDetails
  Container containerForShowPaymentDetails(BuildContext context, String id) {
    final orders = Provider.of<OrderProvider>(context, listen: false)
        .findIdForGettingOrders(id);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(15),
      ),
      height: MediaQuery.of(context).size.height * 0.26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
// For How Much Quantity
          Text(
            "PRICE DETAILS (${Provider.of<OrderProvider>(context, listen: false).totalQty(orders.products!)} items) ",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.grey,
          ),
          ksizedBoxheight10,
// Row contains the Total MRP
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total MRP ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                // value.totalQuantity().toString(),
                "₹ ${orders.totalPrice! + orders.totalPrice! * 15 / 100}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          ksizedBoxheight10,
// Row contains the Discount on MRP
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                overflow: TextOverflow.visible,
                'Discount on MRP',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "- ₹ ${orders.totalPrice! * 15 / 100}",
                style: const TextStyle(fontSize: 18, color: Colors.green),
              ),
            ],
          ),
          ksizedBoxheight10,
          const Divider(
            color: Colors.grey,
          ),
// Row contains the TotalAmount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                overflow: TextOverflow.visible,
                'Total Amount :',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "₹ ${orders.totalPrice!}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
