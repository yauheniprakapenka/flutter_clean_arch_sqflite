import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class UsersPage extends StatefulWidget {
  const UsersPage();

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context, listen: false).add(const GetUsers());
  }

  // Update an existing journal
  // Future<void> _updateItem(int id) async {
  //   await SQFLiteLocalDataSource.updateItem(id, _titleController.text, _descriptionController.text);
  //   _refreshJournals();
  // }

  // Delete an item
  // void _deleteItem(int id) async {
  //   await SQFLiteLocalDataSource.deleteItem(id);
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     content: Text('Successfully deleted a journal!'),
  //   ));
  //   _refreshJournals();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext _, UserState state) {
          if (state is UserData) {
            final List<User> users = state.users;
            if (users.isEmpty) return const Center(child: Text('No users'));
            return Center(
              child: Column(
                children: <Widget>[
                  ...users.map((User user) {
                    return Text(user.firstName);
                  }).toList(),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddUserPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAddUserPressed() {
    const User user = User(firstName: 'Jack');
    BlocProvider.of<UserBloc>(context, listen: false).add(const AddUser(user: user));
  }
}
