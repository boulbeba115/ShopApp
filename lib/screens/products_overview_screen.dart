import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../widgets/Badge.dart';
import '../widgets/product_grid.dart';

enum FilterOptions { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          PopupMenuButton(
            onSelected: (selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              ),
              const PopupMenuItem(
                child: Text('Only Favorite'),
                value: FilterOptions.favorites,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, child) => Badge(
              child: child!,
              value: cartData.itemCount.toString(),
              color: Colors.red.shade700,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScrenn.routeName);
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductGrid(showFavoriteOnly: _showFavoriteOnly),
    );
  }
}
