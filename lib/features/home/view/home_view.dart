import 'package:amazon_clone/features/home/view/widgets/custom_app_bar_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/user_provider.dart';
import 'widgets/address_box.dart';
import 'widgets/carousel_image.dart';
import 'widgets/deal_of_day.dart';
import 'widgets/top_categories.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    return Scaffold(
      appBar: const CustomAppBarHome(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 10),
            TopCategories(),
            SizedBox(height: 10),
            CarouselImage(),
            SizedBox(height: 10),
            DealOfDay(),
            AddressBox(),
          ],
        ),
      ),
    );
  }
}
