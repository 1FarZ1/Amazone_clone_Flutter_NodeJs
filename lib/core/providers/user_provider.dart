import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';

final userStateProvider = StateNotifierProvider<UserSt, User?>((ref) {
  return UserSt();
});

class UserSt extends StateNotifier<User?> {
  UserSt() : super(null);

  void setUser(User user) {
    log("emiiteed");
    state = user;
  }

  void removeUser() {
    state = null;
  }

  bool isUserLoggedIn() {
    return state != null;
  }
}
