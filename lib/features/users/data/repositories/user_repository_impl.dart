import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final users = await remoteDataSource.getUsers();
      return Right(users);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
