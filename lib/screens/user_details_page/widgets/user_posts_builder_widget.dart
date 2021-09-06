import 'package:flutter/material.dart';
import 'package:flutter_presentation_app/ui/shared_widgets/error_message_widget.dart';

import '/domain/api_client/api_client.dart';
import '/domain/entity/post.dart';
import '/navigation/main_navigation.dart';

class UserPostsBuilder extends StatelessWidget {
  final int userId;
  final int numberOfPostsShown;
  const UserPostsBuilder(
      {Key? key, this.userId = 0, this.numberOfPostsShown = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient.instance();
    return FutureBuilder(
      future: apiClient.getUserPosts(userId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('Пусто это не густо ...');
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(
                child: ErrorMessageWidget(
                  errorMessage: snapshot.error.toString(),
                ),
              );
              // return Text('Error: ${snapshot.error}');
            } else {
              final List<Post> posts = snapshot.data;
              return _postsListBuilder(posts, context);
            }
        }
      },
    );
  }

  Widget _postsListBuilder(List<Post> posts, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: numberOfPostsShown,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 200,
                child: Card(
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () => _onTapShowPost(context, posts[index]),
                    title: Text(
                      posts[index].title,
                      style: Theme.of(context).textTheme.headline3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      posts[index].body,
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 1,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        TextButton(
          onPressed: () => _onTapShowAll(context, posts),
          child: Text('Посмотреть все посты (${posts.length})'),
        ),
      ],
    );
  }

  void _onTapShowAll(BuildContext context, List<Post> posts) {
    Navigator.pushNamed(
      context,
      MainNavigationRouteNames.posts,
      arguments: posts,
    );
  }

  void _onTapShowPost(BuildContext context, Post post) {
    Navigator.pushNamed(
      context,
      MainNavigationRouteNames.postDetails,
      arguments: post,
    );
  }
}
