import 'package:amazon_clone/features/account/controller/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/loader.dart';
import '../../../../core/constant/constants.dart';
import 'single_product.dart';

class Orders extends ConsumerStatefulWidget {
  const Orders({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(accountControllerProvider.notifier).getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(accountControllerProvider).when(
      data: (orders) {
        if (orders == null) {
          return const Center(child: Text("No Orders Yet"));
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: const Text(
                    'Your Orders',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: AppConsts.selectedNavBarColor,
                    ),
                  ),
                ),
              ],
            ),
            // display orders
            Container(
              height: 170,
              padding: const EdgeInsets.only(
                left: 10,
                top: 20,
                right: 0,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: orders!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   OrderDetailScreen.routeName,
                      //   arguments: orders![index],
                      // );
                    },
                    child: SingleProduct(
                      image: orders![index].products[0].images[0],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text("No Orders Yet"));
      },
      loading: () {
        return const Center(
          child: Loader(),
        );
      },
    );
  }
}
