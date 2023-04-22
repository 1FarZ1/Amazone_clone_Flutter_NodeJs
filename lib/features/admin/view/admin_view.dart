import 'package:amazon_clone/features/admin/view/widgets/custom_app_bar_admin.dart';
import 'package:flutter/material.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarAdmin(),
      body: Center(
        child: Text("admin Screen"),
      ),
    );
  }
}
