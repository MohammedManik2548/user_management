import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';
import '../datasources/user_remote_datasource.dart';
import '../datasources/user_local_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;
  final UserLocalDataSource local;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getUsers({required int page, required int perPage}) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteUsers = await remote.fetchUsers(page: page, perPage: perPage);
        await local.cacheUsers(remoteUsers);
        return Right(remoteUsers);
      } else {
        final cached = await local.getCachedUsers();
        return Right(cached);
      }
    } on CacheException {
      return Left(CacheFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
