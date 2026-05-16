part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action is taken.
class UsersInitial extends UsersState {
  const UsersInitial();
}

/// Loading state while fetching users from the API.
class UsersLoading extends UsersState {
  const UsersLoading();
}

/// State when users have been successfully loaded and optionally filtered.
class UsersLoaded extends UsersState {
  /// The complete unfiltered list fetched from the API.
  final List<User> allUsers;

  /// The filtered list currently shown in the UI.
  final List<User> filteredUsers;

  /// The active search query.
  final String query;

  const UsersLoaded({
    required this.allUsers,
    required this.filteredUsers,
    this.query = '',
  });

  @override
  List<Object?> get props => [allUsers, filteredUsers, query];
}

/// State when an error has occurred.
class UsersError extends UsersState {
  final String message;

  const UsersError({required this.message});

  @override
  List<Object?> get props => [message];
}
