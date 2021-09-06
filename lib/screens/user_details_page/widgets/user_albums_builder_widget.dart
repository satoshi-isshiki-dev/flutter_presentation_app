import 'package:flutter/material.dart';

import '/domain/api_client/api_client.dart';
import '/domain/entity/album.dart';
import '/navigation/main_navigation.dart';
import '/ui/shared_widgets/error_message_widget.dart';

class UserAlbumsBuilder extends StatelessWidget {
  final int userId;
  final int numberOfAlbumShown;
  const UserAlbumsBuilder({
    Key? key,
    this.userId = 0,
    this.numberOfAlbumShown = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient.instance();
    return FutureBuilder(
      future: apiClient.getUserAlbums(userId),
      initialData: '42',
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
              final List<Album> albums = snapshot.data;
              return _albumsListBuilder(albums, context);
            }
        }
      },
    );
  }

  Widget _albumsListBuilder(List<Album> albums, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: numberOfAlbumShown,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 200,
                child: Card(
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () => _onTapShowAlbum(context, albums[index]),
                    title: Text(
                      albums[index].title,
                      style: Theme.of(context).textTheme.headline3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        TextButton(
          onPressed: () => _onTapShowAll(context, albums),
          child: Text('Посмотреть все альбомы (${albums.length})'),
        ),
      ],
    );
  }

  void _onTapShowAll(BuildContext context, List<Album> albums) {
    Navigator.pushNamed(
      context,
      MainNavigationRouteNames.albums,
      arguments: albums,
    );
  }

  void _onTapShowAlbum(BuildContext context, Album album) {
    Navigator.pushNamed(
      context,
      MainNavigationRouteNames.albumDetails,
      arguments: album,
    );
  }
}
