import 'package:dartz/dartz.dart';
import '../repositories/user_repository.dart';
import '../../core/errors/failures.dart';
import '../entities/user.dart';

class GetUsers {
  final UserRepository repository;
  GetUsers(this.repository);

  Future<Either<Failure, List<User>>> call({required int page, required int perPage}) {
    return repository.getUsers(page: page, perPage: perPage);
  }
}
