import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'presentation/pages/user_list_page.dart';
import 'data/datasources/user_remote_datasource.dart';
import 'data/datasources/user_local_datasource.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/usecases/get_users.dart';
import 'core/network/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/controllers/user_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio();
  final remote = UserRemoteDataSourceImpl(dio);
  final local = UserLocalDataSourceImpl(prefs);
  final networkInfo = NetworkInfoImpl(Connectivity());
  final repo = UserRepositoryImpl(remote: remote, local: local, networkInfo: networkInfo);
  final getUsers = GetUsers(repo);

  Get.put(UserController(getUsers: getUsers));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const UserListPage(),
    );
  }
}
