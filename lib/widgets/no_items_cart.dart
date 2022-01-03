import 'package:flutter/material.dart';

class NoIteamsInCart extends StatelessWidget {
  const NoIteamsInCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.shopping_cart_rounded,
          color: Theme.of(context).colorScheme.secondary,
          size: 80,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'The Cart Is Empty !',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'You will find a lot of interesting products on our shop',
          softWrap: true,
          style: TextStyle(color: Colors.grey.shade400),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text(
                'Home Page',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ]),
    );
  }
}
