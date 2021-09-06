import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/post_details_page/view_model/post_details_view_model.dart';
import '/ui/shared_widgets/error_message_widget.dart';

class CommentForm extends StatelessWidget {
  final int postId;
  const CommentForm({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<PostDetailsViewModel>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50.0),
          // const Text('Имя пользователя'),
          TextField(
            controller: model.nameTextController,
            minLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              prefixIcon: const Icon(Icons.create),
              hintText: 'Имя Пользователя',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: model.emailTextController,
            minLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              prefixIcon: const Icon(Icons.email),
              hintText: 'E-mail',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: model.bodyTextController,
            minLines: 2,
            maxLines: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: 'Комментарий',
            ),
          ),
          ErrorMessageWidget(
            errorMessage:
                context.watch<PostDetailsViewModel>().validationErrorMessage,
          ),
          ElevatedButton(
            onPressed: () => model.addComment(postId, context),
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
