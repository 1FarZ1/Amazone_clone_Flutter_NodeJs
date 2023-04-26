import 'package:amazon_clone/features/posts/controller/posts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common/loader.dart';
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
    ref
        .read(postControllerProvider.notifier)
        .deletePost(context: context, id: product.id);
  }

  void navigateToAddProduct() {
    GoRouter.of(context).push("/add-product");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(postControllerProvider).when(
        data: (products) {
          if (products == [] || products == null) {
            return const Center(child: Text("No Posts Yet"));
          }

          return Scaffold(
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final productData = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(
                        image: productData.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
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
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
