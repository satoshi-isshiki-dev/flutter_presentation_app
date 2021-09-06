
import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String? errorMessage;
  const ErrorMessageWidget({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (errorMessage == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        errorMessage!,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.red,
        ),
      ),
    );
  }
}
