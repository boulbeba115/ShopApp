import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';

class AddEditProductScreen extends StatefulWidget {
  static const routeName = '/add-edit-product';
  const AddEditProductScreen({Key? key}) : super(key: key);

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _initValue = {
    'title': '',
    'description': '',
    'price': 0,
  };
  Product _product = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  void _saveForm() {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();

    if (_product.id != null) {
      Provider.of<Products>(context, listen: false).updateProduct(_product);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_product);
    }
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final String? productId =
            ModalRoute.of(context)!.settings.arguments as String;
        if (productId != null) {
          _product = Provider.of<Products>(context, listen: false)
              .getProductById(productId);
          _initValue = {
            'title': _product.title,
            'description': _product.description,
            'price': _product.price.toString(),
          };
          _imageUrlController.text = _product.imageUrl;
        }
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValue['title'] as String,
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide a value.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _product = Product(
                      id: _product.id,
                      title: value!,
                      description: _product.description,
                      price: _product.price,
                      imageUrl: _product.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initValue['price'].toString(),
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a price.";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid number.";
                  }
                  if (double.parse(value) <= 0) {
                    return "Please enter a number greater then 0.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _product = Product(
                      id: _product.id,
                      title: _product.title,
                      description: _product.description,
                      price: double.parse(value!),
                      imageUrl: _product.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initValue['description'] as String,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a description.";
                  }
                  if (value.length < 10) {
                    return "description should be at least 10 charecters long.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _product = Product(
                      id: _product.id,
                      title: _product.title,
                      description: value!,
                      price: _product.price,
                      imageUrl: _product.imageUrl);
                },
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Center(child: Text('Enter URL'))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image Url'),
                      maxLines: 3,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter ImageUrl.";
                        }
                        if (!value.startsWith('http://') &&
                            !value.startsWith('https://')) {
                          return "Please provide a valid url";
                        }
                        if (!value.endsWith('png') &&
                            !value.endsWith('jpg') &&
                            !value.endsWith('webp') &&
                            !value.endsWith('gif')) {
                          return "Please provide a valid url";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _product = Product(
                            id: _product.id,
                            title: _product.title,
                            description: _product.description,
                            price: _product.price,
                            imageUrl: value!);
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
