import 'package:flutter/material.dart';
import 'package:flutter_presentation_app/screens/post_details_page/view_model/post_details_view_model.dart';

import 'package:flutter_presentation_app/screens/screens.dart';
import 'package:flutter_presentation_app/domain/entity/entities.dart';
import 'package:provider/provider.dart';

abstract class MainNavigationRouteNames {
  static const users = 'users';
  static const userDetails = '/user_details';
  static const posts = '/posts';
  static const postDetails = '/post_details';
  static const albums = '/albums';
  static const albumDetails = '/album_details';
}

class MainNavigation {
  String get initRoute => MainNavigationRouteNames.users;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.users: (context) => const ListUserPage(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.userDetails:
        return toUserDetailsRoute(settings);
      case MainNavigationRouteNames.postDetails:
        return toPostDetailsRoute(settings);
      case MainNavigationRouteNames.posts:
        return toPostListRoute(settings);
      case MainNavigationRouteNames.albums:
        return toAlbumListRoute(settings);
      case MainNavigationRouteNames.albumDetails:
        return toAlbumDetailsRoute(settings);
      default:
        return MaterialPageRoute(builder: (context) => const Error404());
    }
  }

  MaterialPageRoute<Object> toUserDetailsRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    // final user = arguments is User ? arguments : null;
    final user = arguments as User;
    return MaterialPageRoute(
      builder: (context) => UserDetailsPage(user: user),
    );
  }

  MaterialPageRoute<Object> toPostDetailsRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    final post = arguments is Post ? arguments : null;
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
          create: (context) => PostDetailsViewModel(),
          child: PostDetailsPage(post: post)),
    );
  }

  MaterialPageRoute<Object> toPostListRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    final List<Post> posts = arguments is List<Post> ? arguments : [];
    return MaterialPageRoute(
      builder: (context) => PostListPage(posts: posts),
    );
  }

  MaterialPageRoute<Object> toAlbumListRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    // final List<Album> albums = arguments is List<Album> ? arguments : [];
    final List<Album> albums = arguments as List<Album>;
    return MaterialPageRoute(
      builder: (context) => AlbumListPage(albums: albums),
    );
  }

  MaterialPageRoute<Object> toAlbumDetailsRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    // final album = arguments is Album ? arguments : null;
    final album = arguments as Album;
    return MaterialPageRoute(
      builder: (context) => AlbumDetailsPage(album: album),
    );
  }
}
