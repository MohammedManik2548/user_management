import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> fetchUsers({required int page, required int perPage});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;
  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<List<UserModel>> fetchUsers({required int page, required int perPage}) async {
    final response = await dio.get(
      'https://reqres.in/api/users',
      queryParameters: {'per_page': perPage, 'page': page},
      options: Options(
        headers: {
          "x-api-key": "reqres-free-v1"
        },
          sendTimeout: Duration(seconds: 5000), receiveTimeout: Duration(seconds: 5000)
      ),
    );
    if (response.statusCode == 200) {
      final data = response.data;
      final List<dynamic> list = data['data'] as List<dynamic>;
      return list.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
