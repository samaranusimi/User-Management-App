import 'package:flutter/material.dart';
import 'package:user_management/models/user.dart';
import 'package:user_management/sevices/user_service.dart';

class EditUser extends StatefulWidget {
  // const EditUser({super.key, required User user});
  final User user;
  const EditUser({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var _userService = UserService();

  @override
  void initState() {
    // TODO: implement initState
    nameController.text = widget.user.name ?? "";
    contactController.text = widget.user.contact ?? "";
    descriptionController.text = widget.user.description ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EDIT USER"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Name",
                  hintText: "Edit Text"),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: contactController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Contact",
                  hintText: "Edit Contact"),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Description",
                  hintText: "Edit Description"),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        updateData();
                      });
                    },
                    child: Text("Update")),
                SizedBox(
                  width: 50,
                ),
                ElevatedButton(onPressed: () {}, child: Text("Reset"))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future updateData() async {
    var _user = User();
    _user.id = widget.user.id;
    _user.name = nameController.text;
    _user.contact = contactController.text;
    _user.description = descriptionController.text;

    var result = await _userService.updateUser(_user);
    Navigator.pop(context, result);
  }
}
