import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/no_items.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Order;

class OrderScreen extends StatelessWidget {
  static const routename = 'orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersContainer = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      drawer: const AppDrawer(),
      body: ordersContainer.orders.length > 0
          ? ListView.builder(
              itemBuilder: (context, index) =>
                  OrderItem(order: ordersContainer.orders[index]),
              itemCount: ordersContainer.orders.length)
          : const NoIteams(
              title: 'No Order Found',
              icon: Icons.shopping_basket,
            ),
    );
  }
}
