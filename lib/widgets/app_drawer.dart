import 'package:flutter/material.dart';
import 'package:shop/screens/order_screen.dart';

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
          Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrderScreen.routename),
          ),
        ],
      ),
    );
  }
}
