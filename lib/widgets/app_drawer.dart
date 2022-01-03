import 'package:flutter/material.dart';
import 'package:shop/screens/order_screen.dart';
import 'package:shop/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Shop App'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_basket_rounded),
            title: const Text('Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrderScreen.routename),
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName),
          ),
        ],
      ),
    );
  }
}
