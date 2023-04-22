import 'dart:developer';

import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/features/posts/controller/posts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/loader.dart';
import '../../../core/providers/product_provider.dart';
import '../../../models/product.dart';
import '../../account/view/widgets/single_product.dart';

class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  List<Product>? products;
  // final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      ref.read(postControllerProvider.notifier).getPosts(context: context);
    });
  }

  void deleteProduct(Product product, int index) {
    ref.read(postControllerProvider.notifier).deletePost(context: context,id:index);
  }

  void navigateToAddProduct() {
    // Navigator.pushNamed(context, AddProductScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(postControllerProvider).when(
        data: (products) {
          if (products == null) {
            return const Center(child: Text("No Posts Yet"));
          }

          return Scaffold(
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(
                        image: productData["images"][0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData["name"],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteProduct(productData, index),
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        },
        error: (_, __) {
          return Text(_.toString());
        },
        loading: () {
          return const Loader();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
