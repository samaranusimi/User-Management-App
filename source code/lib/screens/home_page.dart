import 'package:flutter/material.dart';
import 'package:user_management/screens/add_user.dart';
import 'package:user_management/models/user.dart';
import 'package:user_management/screens/edit_user.dart';
import 'package:user_management/screens/view_user.dart';
import 'package:user_management/sevices/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  // final User user;
  // const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<User> _userList = <User>[];
  final _userService = UserService();

  getAllUsers() async {
    var users = await _userService.readAllUserData();
    _userList = <User>[];
    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];
        _userList.add(userModel);
      });
    });
  }

  void initState() {
    getAllUsers();
    super.initState();
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  _deletaDataDialog(BuildContext content, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: Text("Are you sure"),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    var result = await _userService.deleteUser(userId);
                    setState(() {
                      if (result != null) Navigator.pop(context);
                      getAllUsers();
                      _showSnackBar("User has been deleted!");
                    });
                  },
                  child: Text("Delete")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite CRUD"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewUser(user: _userList[index])));
              },
              leading: Icon(Icons.person),
              title: Text(_userList[index].name ?? ''),
              subtitle: Text(_userList[index].contact ?? ''),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Expanded(
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) =>
                                          EditUser(user: _userList[index])))
                                  .then((data) {
                                if (data != null) {
                                  getAllUsers();
                                  _showSnackBar("User has been updated!");
                                }
                              });
                            },
                            icon: Icon(Icons.edit))),
                    Expanded(
                        child: IconButton(
                            onPressed: () {
                              _deletaDataDialog(context, _userList[index].id);
                            },
                            icon: Icon(Icons.delete)))
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddUser()));
        },
        child: Icon(Icons.add),
        shape: StadiumBorder(),
      ),
    );
  }
}
