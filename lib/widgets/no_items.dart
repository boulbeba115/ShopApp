// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class NoIteams extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  const NoIteams({
    required this.title,
    this.subtitle,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
          size: 80,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          subtitle ?? '',
          softWrap: true,
          style: TextStyle(color: Colors.grey.shade400),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/');
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
