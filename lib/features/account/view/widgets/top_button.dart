

import 'package:amazon_clone/features/account/controller/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'account_button.dart';

class TopButtons extends ConsumerWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context,ref) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
              onTap: () {},
            ),
            AccountButton(
              text: 'Turn Seller',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out', onTap: () {
                ref.read(accountControllerProvider.notifier).logOut();
              },


            ),
            AccountButton(
              text: 'Your Wish List',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
