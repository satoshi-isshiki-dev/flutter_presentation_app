import 'package:flutter/material.dart';

class Error404 extends StatelessWidget {
  const Error404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Такого экрана нет!'),
      ),
      body: const Center(child: Text('404')),
    );
  }
}
