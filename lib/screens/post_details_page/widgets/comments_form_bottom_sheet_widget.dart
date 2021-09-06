import 'package:flutter/material.dart';
import 'package:flutter_presentation_app/screens/post_details_page/view_model/post_details_view_model.dart';
import 'package:provider/provider.dart';

import 'comments_form_widget.dart';

class CommentFormBottomSheet extends StatelessWidget {
  final int postId;
  const CommentFormBottomSheet({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(35.0),
            ),
          ),
          isScrollControlled: true,
          context: context,
          builder: (BuildContext ctx) => ChangeNotifierProvider.value(
            value: context.read<PostDetailsViewModel>(),
            child: CommentForm(postId: postId),
          ),
        );
      },
      elevation: 1,
      tooltip: 'Добавить комментарий',
    );
  }
}
