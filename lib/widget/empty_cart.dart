import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Cart Is Empty",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Add Product",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ))
      ],
    ));
  }
}
