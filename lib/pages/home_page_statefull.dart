import 'package:exam/models/user.dart';
import 'package:exam/service/user_service.dart';
import 'package:flutter/material.dart';

class HomePageStateful extends StatefulWidget {
  const HomePageStateful({super.key});

  @override
  State<HomePageStateful> createState() => _HomePageStateful();
}

class _HomePageStateful extends State<HomePageStateful> {
  List<User> users = [];

  void fetchUsers() async {
    final result = await UserService.fetchUsers();
    setState(() {
      users = result;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  void editUser(int index, String newTitle, String newUrl, String newThumbnailUrl) {
    setState(() {
      users[index].title = newTitle;
      users[index].url = newUrl;
      users[index].thumbnailUrl = newThumbnailUrl;
    });
  }

  void showEditDialog(BuildContext context, int index) {
    TextEditingController titleController = TextEditingController(text: users[index].title);
    TextEditingController urlController = TextEditingController(text: users[index].url);
    TextEditingController thumbnailUrlController = TextEditingController(text: users[index].thumbnailUrl);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: urlController,
                decoration: InputDecoration(labelText: 'URL'),
              ),
              TextField(
                controller: thumbnailUrlController,
                decoration: InputDecoration(labelText: 'Thumbnail URL'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                editUser(index, titleController.text, urlController.text, thumbnailUrlController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get API Stateful'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.thumbnailUrl),
              ),
              title: Text('${user.id} ${user.title}'),
              subtitle: Text(user.url),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => showEditDialog(context, index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteUser(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}