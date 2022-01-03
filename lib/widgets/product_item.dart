import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final cartContainer = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        elevation: 10,
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.indigo,
            leading: Consumer<Product>(
              builder: (context, product, _) => IconButton(
                icon: product.isfavorite
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                onPressed: () {
                  product.toggleFavoriteSatus();
                },
              ),
            ),
            title: FittedBox(
              child: Text(
                product.title,
                textAlign: TextAlign.center,
                softWrap: false,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                cartContainer.addItem(product, 1);
              },
            ),
          ),
        ),
      ),
    );
  }
}
