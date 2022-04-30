import 'dart:developer';

import 'package:domain/domain.dart';
import 'package:sqflite/sqflite.dart';

import '../../mappers/user_mapper.dart';
import 'user_local_data_source.dart';

class UserSqfliteDataSource implements UserLocalDataSource {
  static const String _dataBasePath = 'users.db';
  static const String _usersTable = 'usersTable';
  static const String _userFirstNameValue = 'firstName';
  static const String _orderById = 'id';

  @override
  Future<void> createUser({required User user}) async {
    final Database dataBase = await _openDataBase();
    final Map<String, String> data = <String, String>{_userFirstNameValue: user.firstName};
    await dataBase.insert(_usersTable, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<User>> getUsers() async {
    final Database dataBase = await _openDataBase();
    final List<Map<String, dynamic>> usersMap = await dataBase.query(_usersTable, orderBy: _orderById);
    return usersMap.map(UserMapper.fromJson).toList();
  }

  @override
  Future<void> deleteUserByID({required int userId}) async {
    final Database dataBase = await _openDataBase();
    await dataBase.delete(_usersTable, where: 'id = ?', whereArgs: <int>[userId]);
  }

  @override
  Future<void> updateUser({required User user}) async {
    final int? userId = user.id;
    if (userId == null) {
      log('User id must not be null');
      return;
    }
    final Database dataBase = await _openDataBase();
    final Map<String, dynamic> data = <String, dynamic>{
      _userFirstNameValue: user.firstName,
    };
    await dataBase.update(_usersTable, data, where: 'id = ?', whereArgs: <int>[userId]);
  }

  Future<Database> _openDataBase() async {
    return openDatabase(
      _dataBasePath,
      version: 2,
      onCreate: (Database database, int version) async {
        await _createTables(database);
      },
    );
  }

  static Future<void> _createTables(Database database) async {
    await database.execute(
      '''
      CREATE TABLE $_usersTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $_userFirstNameValue TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      ''',
    );
  }
}
