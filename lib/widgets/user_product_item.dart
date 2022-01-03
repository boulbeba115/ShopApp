import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/add_edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  const UserProductItem({
    required this.id,
    required this.title,
    required this.imgUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productContainer = Provider.of<Products>(context, listen: false);

    return Card(
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imgUrl),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AddEditProductScreen.routeName,
                      arguments: id,
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.orangeAccent,
                  )),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text(
                              'Are you sure',
                              textAlign: TextAlign.center,
                            ),
                            content: const Text(
                              'Do you want to remove this product',
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                  productContainer.deleteProduct(id);
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text(
                                  'No',
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Theme.of(context).errorColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
