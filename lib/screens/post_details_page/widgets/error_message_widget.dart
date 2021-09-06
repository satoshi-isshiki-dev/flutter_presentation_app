import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_presentation_app/screens/post_details_page/view_model/post_details_view_model.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String? errorMessage;
  const ErrorMessageWidget({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ? watch() потому что, сообщения об оишбках будут менятся, и нужно этот виджет обновлять
    // final errorMessage = context.watch<PostDetailsViewModel>().errorMesage;

    if (errorMessage == null) {
      // ? shrink() сделать размер мелким на сколько это позволит родитель.
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        errorMessage!,
        style: const TextStyle(
          fontSize: 12.0,
          color: Colors.red,
        ),
      ),
    );
  }
}
