// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import './product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = DUMMY_DATA;
  late bool _showFavoriteOnly = false;

  List<Product> get items {
    return [..._items];
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  List<Product> getFavoriteProducts() {
    return _items.where((product) => product.isfavorite).toList();
  }

  Product getProductById(String productId) {
    return items.firstWhere((product) => product.id == productId);
  }

  void toggleFavoriteOnly(bool flag) {
    _showFavoriteOnly = flag;
    notifyListeners();
  }
}
