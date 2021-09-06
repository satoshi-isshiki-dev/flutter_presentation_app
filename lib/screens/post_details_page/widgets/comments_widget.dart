import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/domain/entity/entities.dart';
import '/screens/post_details_page/view_model/post_details_view_model.dart';

class PostCommentsBuilder extends StatelessWidget {
  final int postId;
  const PostCommentsBuilder({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comments = context.watch<PostDetailsViewModel>().comments;
    return Scaffold(
      body: !context.watch<PostDetailsViewModel>().isDone
          ? _LoadCommentsButton(postId: postId)
          : context.watch<PostDetailsViewModel>().isLoading
              ? const CircularProgressIndicator()
              : CommentsListBuilder(comments: comments),
    );
  }
}

class CommentsListBuilder extends StatelessWidget {
  final List<Comment> comments;
  const CommentsListBuilder({
    Key? key,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Название',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(comments[index].name),
                const Text(
                  'E-Mail',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(comments[index].email),
                const SizedBox(height: 10),
                const Text(
                  'Сообщение',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(comments[index].body),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LoadCommentsButton extends StatelessWidget {
  const _LoadCommentsButton({Key? key, required this.postId}) : super(key: key);

  final int postId;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: TextButton(
        child: context.watch<PostDetailsViewModel>().isLoading
            ? const CircularProgressIndicator()
            : const Text('Загрузить комментарии'),
        onPressed: () {
          context.read<PostDetailsViewModel>().fetchComments(postId);
        },
      ),
    );
  }
}
