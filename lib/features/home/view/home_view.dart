import 'package:amazon_clone/features/home/view/widgets/custom_app_bar_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/user_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    return Scaffold(
      appBar: const CustomAppBarHome(),
      body: Center(
        child: Column(
          children: [
            Text(user == null ? "No User" : user.email),
            ElevatedButton(
              onPressed: () {
                ref.read(userStateProvider.notifier).removeUser();
              },
              child: const Text("Logout"),
            ),
          ],
        ),

      ),
    );
  }
}
