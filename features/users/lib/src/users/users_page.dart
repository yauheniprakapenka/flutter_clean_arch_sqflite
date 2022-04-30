import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';
import 'widgets/user_card.dart';

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
                    return UserCard(
                      user: user,
                      onDeletePressed: () =>
                          BlocProvider.of<UserBloc>(context, listen: false).add(DeleteUserById(id: user.id!)),
                      onEditPressed: () => _onAddUserPressed(context: context, user: user),
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
        onPressed: () => _onAddUserPressed(context: context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _onAddUserPressed({required BuildContext context, User? user}) async {
    if (user != null) _textFieldController.text = user.firstName;
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
                final User editedUser = User(firstName: userFirstName, id: user?.id);
                user == null
                    ? BlocProvider.of<UserBloc>(context, listen: false).add(CreateUser(user: editedUser))
                    : BlocProvider.of<UserBloc>(context, listen: false).add(UpdateUser(user: editedUser));
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
