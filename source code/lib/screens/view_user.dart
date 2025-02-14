import 'package:flutter/material.dart';
import 'package:user_management/models/user.dart';
import 'package:user_management/sevices/user_service.dart';

class ViewUser extends StatefulWidget {
  // const ViewUser({super.key});
  final User user;
  const ViewUser({super.key, required this.user});

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VIEW USER"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        height: 200,
        padding: EdgeInsets.all(20),
        child: Card(
          color: Colors.blueAccent,
          elevation: 15,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "ID: ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      widget.user.id.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Name: ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(widget.user.name ?? "",
                        style: TextStyle(fontSize: 18, color: Colors.white))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Contact: ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(widget.user.contact ?? "",
                        style: TextStyle(fontSize: 18, color: Colors.white))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Description: ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(widget.user.description ?? "",
                        style: TextStyle(fontSize: 18, color: Colors.white))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
