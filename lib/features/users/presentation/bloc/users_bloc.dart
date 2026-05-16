import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsers getUsers;

  UsersBloc({required this.getUsers}) : super(const UsersInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<FilterUsers>(_onFilterUsers);
  }

  Future<void> _onFetchUsers(
    FetchUsers event,
    Emitter<UsersState> emit,
  ) async {
    emit(const UsersLoading());

    final result = await getUsers(NoParams());

    result.fold(
      (failure) => emit(const UsersError(message: 'Failed to fetch users. Please check your connection.')),
      (users) => emit(UsersLoaded(
        allUsers: users,
        filteredUsers: users,
        query: '',
      )),
    );
  }

  void _onFilterUsers(
    FilterUsers event,
    Emitter<UsersState> emit,
  ) {
    final currentState = state;
    if (currentState is UsersLoaded) {
      final query = event.query.toLowerCase().trim();
      final filtered = query.isEmpty
          ? currentState.allUsers
          : currentState.allUsers
              .where((user) => user.name.toLowerCase().contains(query))
              .toList();

      emit(UsersLoaded(
        allUsers: currentState.allUsers,
        filteredUsers: filtered,
        query: event.query,
      ));
    }
  }
}
