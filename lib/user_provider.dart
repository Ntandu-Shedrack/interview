import 'package:flutter/material.dart';
import 'user.dart';
import 'user_service.dart';

enum UserState { initial, loading, loaded, error }

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];
  String _query = '';
  UserState _state = UserState.initial;
  String _errorMessage = '';

  List<User> get users => _filteredUsers;
  List<User> get allUsers => _allUsers;
  UserState get state => _state;
  String get errorMessage => _errorMessage;
  String get query => _query;

  Future<void> loadUsers() async {
    _state = UserState.loading;
    notifyListeners();

    try {
      _allUsers = await _userService.fetchUsers();
      _filterUsers();
      _state = UserState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = UserState.error;
    }
    notifyListeners();
  }

  void searchUsers(String query) {
    _query = query;
    _filterUsers();
    notifyListeners();
  }

  void _filterUsers() {
    if (_query.isEmpty) {
      _filteredUsers = List.from(_allUsers);
    } else {
      _filteredUsers = _allUsers
          .where((user) =>
              user.name.toLowerCase().contains(_query.toLowerCase()) ||
              user.email.toLowerCase().contains(_query.toLowerCase()))
          .toList();
    }
  }
}
