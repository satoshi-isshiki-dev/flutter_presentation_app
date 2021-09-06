import 'package:flutter/material.dart';

import '../widgets/user_albums_builder_widget.dart';
import '../widgets/user_posts_builder_widget.dart';
import '/domain/entity/user.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;
  const UserDetailsPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            _userInfoBuilder(context, user),
            const SizedBox(height: 5),
            _userCompanyInfoBuilder(context, user),
            const SizedBox(height: 20),
            const Text('Последние добавленные посты'),
            UserPostsBuilder(userId: user.id),
            const SizedBox(height: 10),
            const Text('Последние добавленные альбомы'),
            UserAlbumsBuilder(userId: user.id),
          ],
        ),
      ),
    );
  }

  Widget _userInfoBuilder(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 150, height: 150, child: Placeholder()),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text('✉ ${user.email}'),
                    Text('📞 ${user.phone}'),
                    Text('🖥 ${user.website}'),
                    const SizedBox(height: 22),
                    Text('Город 🌃 ${user.address?.city}'),
                    Text('Улица ${user.address?.street} ${user.address?.suite}')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _userCompanyInfoBuilder(BuildContext context, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text('Компания 🏰'),
                Text(
                  user.company?.name ?? '',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text('Деятельность'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        user.company?.bs ?? '',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text('Лозунг'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        user.company?.catchPhrase ?? '',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
