import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';

final userStateProvider = StateNotifierProvider<UserSt, User>((ref) {
  return UserSt();
});

class UserSt extends StateNotifier<User> {
  UserSt() : super(User.empty());

  void setUser(User user) {
    state = user;
  }

  void removeUser() {
    state = User.empty();
  }

  bool isUserLoggedIn() {
    return !(state.equals(User.empty()));
  }
}