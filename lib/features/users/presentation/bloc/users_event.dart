part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered on page load to fetch all users from the API.
class FetchUsers extends UsersEvent {
  const FetchUsers();
}

/// Triggered whenever the user types in the search field.
class FilterUsers extends UsersEvent {
  final String query;

  const FilterUsers(this.query);

  @override
  List<Object?> get props => [query];
}
