import 'package:flutter/material.dart';
import 'package:flutter_presentation_app/domain/entity/album.dart';
import 'package:flutter_presentation_app/navigation/main_navigation.dart';

class AlbumListPage extends StatelessWidget {
  final List<Album> albums;

  const AlbumListPage({
    Key? key,
    required this.albums,
  }) : super(key: key);

  void _onAlbumTap(BuildContext context, Album album) {
    Navigator.pushNamed(
      context,
      MainNavigationRouteNames.albumDetails,
      arguments: album,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список альбомов пользователя'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: albums.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 3,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => _onAlbumTap(context, albums[index]),
              child: Card(
                elevation: 7.0,
                child: ListTile(
                  title: Center(
                    child: Text(
                      albums[index].title,
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
