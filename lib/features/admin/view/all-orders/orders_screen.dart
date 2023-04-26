import 'package:amazon_clone/features/admin/view/all-orders/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/loader.dart';
import '../../../account/view/widgets/single_product.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ordersControllerProvider.notifier).getAllOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(ordersControllerProvider).when(data:(orders) {
      if(orders == null){
        return const Center(child: Text("No Orders Yet"));
      }
       return GridView.builder(
      itemCount: orders!.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final orderData = orders![index];
        return GestureDetector(
          onTap: () {
            // Navigator.pushNamed(
            //   context,
            //   OrderDetailScreen.routeName,
            //   arguments: orderData,
            // );
          },
          child: SizedBox(
            height: 140,
            child: SingleProduct(
              image: orderData.products[0].images[0],
            ),
          ),
        );
      },
    );
    }, error:(error, stackTrace) {
      return const Center(child: Text("Error"));
    }, loading:() {
      return const Center(child: Loader(),);
    },);
    
  }
}


