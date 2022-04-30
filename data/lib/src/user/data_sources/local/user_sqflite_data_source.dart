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

// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

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

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  Future<List<Map<String, dynamic>>> getItem(int id) async {
    final Database db = await _openDataBase();
    return db.query('items', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  // Update an item by id
  Future<int> updateItem(int id, String title, String? descrption) async {
    final Database db = await _openDataBase();

    final Map<String, String?> data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final int result = await db.update('items', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }
}
