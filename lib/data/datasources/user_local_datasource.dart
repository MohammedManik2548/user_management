import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../../core/errors/exceptions.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUsers(List<UserModel> users);
  Future<List<UserModel>> getCachedUsers();
}

const CACHED_USERS = 'CACHED_USERS';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences prefs;
  UserLocalDataSourceImpl(this.prefs);

  @override
  Future<void> cacheUsers(List<UserModel> users) {
    final jsonString = json.encode(users.map((u) => u.toJson()).toList());
    return prefs.setString(CACHED_USERS, jsonString);
  }

  @override
  Future<List<UserModel>> getCachedUsers() {
    final jsonString = prefs.getString(CACHED_USERS);
    if (jsonString == null) {
      throw CacheException();
    }
    final List<dynamic> decoded = json.decode(jsonString);
    return Future.value(decoded.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList());
  }
}
