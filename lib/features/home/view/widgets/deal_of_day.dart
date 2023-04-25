import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/features/home/controllers/home_controller.dart';
import 'package:amazon_clone/features/product-detaills/controller/product_detaills_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/loader.dart';
import '../../../../models/product.dart';

class DealOfDay extends ConsumerStatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  ConsumerState<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends ConsumerState<DealOfDay> {
  Product? product;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDealOfDay();
    });
  }

  void fetchDealOfDay() {
    ref.read(homeControllerProvider.notifier).getDealOfTheDay();
  }

  void navigateToDetailScreen(Product product) {
    ref.read(productDetaillsControllerProvider.notifier).setProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(homeControllerProvider).when(data: (product) {
      return product!.name.isEmpty
          ? const SizedBox()
          : GestureDetector(
              onTap: () {
                navigateToDetailScreen(product);
              },
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: const Text(
                      'Deal of the day',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Image.network(
                    product!.images[0],
                    height: 235,
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      '\$100',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                    child: const Text(
                      'Rivaan',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: product!.images
                          .map(
                            (e) => Image.network(
                              e,
                              fit: BoxFit.fitWidth,
                              width: 100,
                              height: 100,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ).copyWith(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'See all deals',
                      style: TextStyle(
                        color: Colors.cyan[800],
                      ),
                    ),
                  ),
                ],
              ),
            );
    }, error: (error, stackTrace) {
      return Text(error.toString());
    }, loading: () {
      return const Loader();
    });
  }
}
