import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(Product product, int quantity) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id as String,
        (existantItem) => CartItem(
            id: existantItem.id,
            product: existantItem.product,
            quantity: existantItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        product.id as String,
        () => CartItem(
          id: const Uuid().v1().toString(),
          product: product,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  double get calculateTotal {
    return _items.values.fold(
        0,
        (previousValue, cartItem) =>
            previousValue + (cartItem.quantity * cartItem.product.price));
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCard() {
    _items.clear();
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity >= 1) {
      _items.update(
          productId,
          (existantItem) => CartItem(
              id: existantItem.id,
              product: existantItem.product,
              quantity: existantItem.quantity - 1));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
