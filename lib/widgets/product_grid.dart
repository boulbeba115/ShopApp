import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  const ProductGrid({
    required this.showFavoriteOnly,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productContainer = Provider.of<Products>(context);
    final loadedProducts = !showFavoriteOnly
        ? productContainer.items
        : productContainer.getFavoriteProducts();
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: loadedProducts[index],
          child: const ProductItem(),
        );
      },
    );
  }
}
