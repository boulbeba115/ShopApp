import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/order_screen.dart';
import '../providers/orders.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Order()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: theme.colorScheme.copyWith(
              secondary: Colors.blue.shade800,
              primary: Colors.indigo,
              background: Colors.red),
          fontFamily: 'Lato',
        ),
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          CartScrenn.routeName: (context) => const CartScrenn(),
          OrderScreen.routename: (context) => const OrderScreen(),
        },
      ),
    );
  }
}
