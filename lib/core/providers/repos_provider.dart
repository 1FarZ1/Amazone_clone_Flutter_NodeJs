


import 'package:amazon_clone/core/api_service.dart';
import 'package:amazon_clone/features/auth/repository/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepoProvider = Provider<AuthRepoImpl>((ref) {
  return  AuthRepoImpl();
});