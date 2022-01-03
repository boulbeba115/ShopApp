// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../data/dummy_data.dart';
import './product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = DUMMY_DATA;
  late bool _showFavoriteOnly = false;

  List<Product> get items {
    return [..._items];
  }

  void addProduct(Product product) {
    product = Product(
      id: const Uuid().v1().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );

    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final productIndex = _items.indexWhere((prod) => prod.id == product.id);
    _items[productIndex] = product;
    notifyListeners();
  }

  List<Product> getFavoriteProducts() {
    return _items.where((product) => product.isfavorite).toList();
  }

  Product getProductById(String productId) {
    return items.firstWhere((product) => product.id == productId);
  }

  void deleteProduct(String productId) {
    _items.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  void toggleFavoriteOnly(bool flag) {
    _showFavoriteOnly = flag;
    notifyListeners();
  }
}
