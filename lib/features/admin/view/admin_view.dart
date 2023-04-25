import 'package:amazon_clone/core/common/bottom_bar.dart';
import 'package:amazon_clone/features/posts/view/posts_view.dart';
import 'package:flutter/material.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBar(
      paramPages: [
        Center(
          child: Text("Admin Screen"),
        ),
        PostsScreen(),
        Center(child: Text("random Widget"))
      ],
    );
  }
}
