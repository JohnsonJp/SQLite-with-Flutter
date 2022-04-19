import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sqlite_flutter/Model/user.dart';
import 'package:sqlite_flutter/services/userService.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var _userNameController = TextEditingController();
  var _userContactController = TextEditingController();
  var _userDescriptionController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  var _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SQLite'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New User',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Name',
                      labelText: 'Name',
                      errorText: _validateName ? 'Name Can\'t Be Empty' : null),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _userContactController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Contact',
                      labelText: 'Contact',
                      errorText:
                          _validateContact ? 'Contact Can\'t Be Empty' : null),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _userDescriptionController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Description',
                      labelText: 'Description',
                      errorText: _validateDescription
                          ? 'Description Can\'t Be Empty'
                          : null),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: () async {
                          setState(() {
                            _userNameController.text.isEmpty
                                ? _validateName = true
                                : _validateName = false;
                            _userContactController.text.isEmpty
                                ? _validateContact = true
                                : _validateContact = false;
                            _userDescriptionController.text.isEmpty
                                ? _validateDescription = true
                                : _validateDescription = false;
                          });

                          if (_validateName == false &&
                              _validateContact == false &&
                              _validateDescription == false) {
                            // print('data can save');
                            var _user = User();
                            _user.name = _userNameController.text;
                            _user.contact = _userContactController.text;
                            _user.description = _userDescriptionController.text;
                            var result = await _userService.SaveUser(_user);
                            Navigator.pop(context, result);
                          }
                        },
                        child: const Text('Save Details')),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          _userNameController.text = '';
                          _userContactController.text = '';
                          _userDescriptionController.text = '';
                        },
                        child: const Text('Clear Details')),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
