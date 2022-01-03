// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../screens/order_screen.dart';
import '../widgets/no_items.dart';
import '../widgets/shopping_card_item.dart';
import '../providers/cart.dart';

class CartScrenn extends StatelessWidget {
  const CartScrenn({Key? key}) : super(key: key);
  static const routeName = '/shopping-cart';
  @override
  Widget build(BuildContext context) {
    final cartContainer = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Card'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: cartContainer.items.isNotEmpty
            ? [
                IconButton(
                  onPressed: () {
                    Provider.of<Order>(context, listen: false).addOrder(
                      cartContainer.items.values.toList(),
                      cartContainer.calculateTotal,
                    );
                    Navigator.of(context)
                        .popAndPushNamed(OrderScreen.routename);
                    cartContainer.clearCard();
                  },
                  icon: const Icon(Icons.shopping_basket),
                )
              ]
            : [],
      ),
      body: cartContainer.items.isEmpty
          ? const NoIteams(
              title: 'The Cart Is Empty !',
              subtitle:
                  'You will find a lot of interesting products on our shop',
              icon: Icons.shopping_cart_rounded,
            )
          : Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Chip(
                          label: Text(
                            '${cartContainer.calculateTotal.toStringAsFixed(2)}\$',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => ShopingCardItem(
                      id: cartContainer.items.values.toList()[index].id,
                      productId: cartContainer.items.values
                          .toList()[index]
                          .product
                          .id as String,
                      price: cartContainer.items.values
                          .toList()[index]
                          .product
                          .price,
                      title: cartContainer.items.values
                          .toList()[index]
                          .product
                          .title,
                      quantity:
                          cartContainer.items.values.toList()[index].quantity,
                    ),
                    itemCount: cartContainer.itemCount,
                  ),
                )
              ],
            ),
    );
  }
}
