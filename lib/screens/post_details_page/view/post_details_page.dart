import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/shared_widgets/error_message_widget.dart';
import '/screens/post_details_page/view_model/post_details_view_model.dart';
import '/screens/post_details_page/widgets/comments_form_widget.dart';
import '/screens/post_details_page/widgets/comments_widget.dart';
import '/domain/entity/post.dart';

class PostDetailsPage extends StatelessWidget {
  final Post? post;
  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пост с комментариями'),
      ),
      body: SafeArea(
        child: post == null
            ? const Text('Поста не будет ...')
            : Column(
                children: [
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Card(
                        elevation: 7.0,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const Text('Тема:'),
                              Text(
                                post?.title ?? '🤷‍♂️',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(post?.body ?? '🤷‍♂️'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Card(
                    elevation: 7.0,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Комментарии:'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ErrorMessageWidget(
                    errorMessage:
                        context.watch<PostDetailsViewModel>().errorMesage,
                  ),
                  Expanded(
                    child: PostCommentsBuilder(postId: post?.id),
                  ),
                  // CommentForm(postId: post!.id),
                ],
              ),
      ),
      floatingActionButton: CommentFormBottomSheet(postId: post!.id),
    );
  }
}

class CommentFormBottomSheet extends StatelessWidget {
  final int postId;
  const CommentFormBottomSheet({Key? key, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
          isScrollControlled: true,
          // backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext ctx) => ChangeNotifierProvider.value(
              value: context.read<PostDetailsViewModel>(),
              child: CommentForm(postId: postId)),
        );
      },
      elevation: 1,
      tooltip: 'Добавить комментарий',
    );
  }
}
