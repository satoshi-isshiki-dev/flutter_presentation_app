import 'package:flutter/material.dart';
import 'package:flutter_presentation_app/app/app_model.dart';

import 'package:flutter_presentation_app/domain/api_client/api_client.dart';
import 'package:flutter_presentation_app/domain/entity/user.dart';
import 'package:flutter_presentation_app/navigation/main_navigation.dart';
import 'package:flutter_presentation_app/ui/shared_widgets/error_message_widget.dart';
import 'package:provider/provider.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient.instance();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pseudo App',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          Consumer<AppModel>(
            builder: (context, appModel, _) {
              return IconButton(
                tooltip: 'Изменить вид отображения списка',
                onPressed: () => appModel.changeListView(),
                icon: context.watch<AppModel>().gridMode
                    ? const Icon(Icons.table_rows_rounded)
                    : const Icon(Icons.grid_view),
              );
            },
          ),
          IconButton(
            tooltip: 'Изменить цветовую тему приложения',
            onPressed: () => context.read<AppModel>().changeAppTheme(),
            icon: const Icon(Icons.color_lens_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: apiClient.getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('Пусто это не густо ...');
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Загружаем псевдо пользователей'),
                    SizedBox(height: 10.0),
                    CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: ErrorMessageWidget(
                    errorMessage: snapshot.error.toString(),
                  ),
                );
                // return Text('Error: ${snapshot.error}');
              } else {
                final List<User> users = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        'Список псевдо пользователей',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Consumer<AppModel>(
                      builder: (context, appModel, _) {
                        return Expanded(
                          child: appModel.gridMode
                              ? _usersGridBuilder(users, context)
                              : _usersListBuilder(users, context),
                        );
                      },
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }

  Widget _usersGridBuilder(List<User> users, BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        // width: 380,
        child: GridView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: users.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 16 / 9,
          ),
          itemBuilder: (context, index) {
            return _usersWidgetBuilder(users, index);
          },
        ),
      ),
    );
  }

  Widget _usersListBuilder(List<User> users, BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        // width: 380,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: users.length,
          itemBuilder: (context, index) {
            return _usersWidgetBuilder(users, index);
          },
        ),
      ),
    );
  }

  Widget _usersWidgetBuilder(List<User> users, int index) {
    return InkWell(
      onTap: () => _onUserTap(context, users[index]),
      child: Card(
        // margin: const EdgeInsets.all(5.0),
        color: context.watch<AppModel>().darkMode
            // ? Colors.[index * 100 % 1000 + 100]
            ? null
            : Colors.amber[index * 100 % 1000],
        // color: Colors.amber[index * 50 % 1000],
        elevation: 5.0,
        child: Center(
          child: ListTile(
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              users[index].username,
              style: Theme.of(context).textTheme.headline2,
            ),
            subtitle: Text(
              users[index].name,
              // style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }

  void _onUserTap(BuildContext context, User user) {
    Navigator.pushNamed(
      context,
      MainNavigationRouteNames.userDetails,
      arguments: user,
    );
  }
}
