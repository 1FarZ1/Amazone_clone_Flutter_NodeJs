import 'package:flutter/material.dart';

import 'widgets/below_app_bar.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/orders.dart';
import 'widgets/top_button.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: const [
            BelowAppBar(),
            SizedBox(height: 10),
            TopButtons(),
            SizedBox(height: 20),
            Orders(),
          ],
        ));
  }
}
