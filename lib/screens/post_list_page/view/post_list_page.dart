import 'package:flutter/material.dart';
import 'package:flutter_presentation_app/domain/entity/post.dart';
import 'package:flutter_presentation_app/navigation/main_navigation.dart';

class PostListPage extends StatelessWidget {
  final List<Post> posts;

  const PostListPage({
    Key? key,
    required this.posts,
  }) : super(key: key);

  void _onPostTap(BuildContext context, Post post) {
    Navigator.pushNamed(
      context,
      MainNavigationRouteNames.postDetails,
      arguments: post,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список постов пользователя'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: posts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 3,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => _onPostTap(context, posts[index]),
              child: Card(
                elevation: 7.0,
                child: ListTile(
                  title: Center(
                    child: Text(
                      posts[index].title,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
