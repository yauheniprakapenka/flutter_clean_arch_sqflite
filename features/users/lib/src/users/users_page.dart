import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';

class UsersPage extends StatefulWidget {
  const UsersPage();

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context, listen: false).add(const GetUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext _, UserState state) {
          if (state is UsersData) {
            final List<User> users = state.users;
            if (users.isEmpty) return const Center(child: Text('No users'));
            return Center(
              child: Column(
                children: <Widget>[
                  ...users.map((User user) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<UserBloc>(context, listen: false).add(DeleteUserById(id: user.id!));
                      },
                      child: Text(
                        user.firstName,
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddUserPressed(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _onAddUserPressed(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('What is your name?'),
          content: TextField(
            controller: _textFieldController,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                final String userFirstName = _textFieldController.text;
                final User user = User(firstName: userFirstName);
                BlocProvider.of<UserBloc>(context, listen: false).add(AddUser(user: user));
                Navigator.of(context).pop();
                _textFieldController.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
