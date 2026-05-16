import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// Counter feature
import 'features/counter/data/repositories/counter_repository_impl.dart';
import 'features/counter/domain/repositories/counter_repository.dart';
import 'features/counter/domain/usecases/increment_counter.dart';
import 'features/counter/presentation/bloc/counter_bloc.dart';

// Users feature
import 'features/users/data/datasources/user_remote_data_source.dart';
import 'features/users/data/repositories/user_repository_impl.dart';
import 'features/users/domain/repositories/user_repository.dart';
import 'features/users/domain/usecases/get_users.dart';
import 'features/users/presentation/bloc/users_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Counter
  sl.registerFactory(() => CounterBloc(incrementCounter: sl()));
  sl.registerLazySingleton(() => IncrementCounter(sl()));
  sl.registerLazySingleton<CounterRepository>(() => CounterRepositoryImpl());

  //! Features - Users
  // Bloc
  sl.registerFactory(() => UsersBloc(getUsers: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUsers(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  //! External
  sl.registerLazySingleton(() => http.Client());
}
