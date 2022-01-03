import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime orderDate;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.orderDate,
  });
}

class Order with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cardItems, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: const Uuid().v1().toString(),
        amount: total,
        orderDate: DateTime.now(),
        products: cardItems,
      ),
    );
    notifyListeners();
  }
}
