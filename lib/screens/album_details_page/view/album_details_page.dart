import 'package:flutter/material.dart';

import '/domain/api_client/api_client.dart';
import '/domain/entity/album.dart';
import '/domain/entity/photo.dart';
import '/screens/album_details_page/widgets/image_slider_widget.dart';
import '/ui/shared_widgets/error_message_widget.dart';

class AlbumDetailsPage extends StatelessWidget {
  final Album album;
  const AlbumDetailsPage({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
      ),
      body: PhotoBuilder(
        albumId: album.id,
      ),
    );
  }
}

class PhotoBuilder extends StatelessWidget {
  final int albumId;
  const PhotoBuilder({Key? key, required this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient.instance();
    return Scaffold(
      body: FutureBuilder(
        future: apiClient.getAlbumPhotos(albumId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('Пусто это не густо...');
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(
                  child: ErrorMessageWidget(
                    errorMessage: snapshot.error.toString(),
                  ),
                );
              } else {
                final List<Photo> photos = snapshot.data;

                final List<Widget> imageSliders = photos
                    .map((item) => ImageForSlider(
                          imageUrl: item.url,
                          imageTitle: item.title,
                        ))
                    .toList();

                return ImageSliderWidget(imageSliders: imageSliders);
              }
          }
        },
      ),
    );
  }
}
