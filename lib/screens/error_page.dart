import 'package:flutter/material.dart';

class Error404 extends StatelessWidget {
  const Error404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Не верный Route'),
      ),
      body: const Center(child: Text('404')),
    );
  }
}
