import 'package:amazon_clone/core/common/loader.dart';
import 'package:amazon_clone/core/constant/constants.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/features/product-detaills/controller/product_detaills_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/stars.dart';
import '../../auth/view/login/widgets/custom_button.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
  }

  void navigateToSearchScreen(String query) {
    // Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    // productDetailsServices.addToCart(
    //   context: context,
    //   product: widget.product,
    // );
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue product = ref.watch(productDetaillsControllerProvider);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppConsts.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 6,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(Icons.mic, color: Colors.black, size: 25),
                ),
              ],
            ),
          ),
        ),
        body: product.when(
          data: (product) {
            if (product == null) {
              return const Center(child: CircularProgressIndicator());
            }
            double totalRating = 0;
            for (int i = 0; i < product.rating!.length; i++) {
              totalRating += product.rating![i].rating;
              if (product.rating![i].userId == ref.read(userStateProvider).id) {
                myRating = product.rating![i].rating;
              }
            }
            if (totalRating != 0) {
              avgRating = totalRating / product.rating!.length;
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.id!,
                        ),
                        Stars(
                          rating: avgRating,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  CarouselSlider(
                    items: product.images.map(
                      (i) {
                        return Builder(
                          builder: (BuildContext context) => Image.network(
                            i,
                            fit: BoxFit.contain,
                            height: 200,
                          ),
                        );
                      },
                    ).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 300,
                    ),
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                      text: TextSpan(
                        text: 'Deal Price: ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: '\$${product.price}',
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(product.description),
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      text: 'Buy Now',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      text: 'Add to Cart',
                      onTap: addToCart,
                      color: const Color.fromRGBO(254, 216, 19, 1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Rate The Product',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: myRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: AppConsts.secondaryColor,
                    ),
                    onRatingUpdate: (rating) {
                      ref
                          .read(productDetaillsControllerProvider.notifier)
                          .rateProduct(
                            rating: rating,
                          );
                    },
                  )
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(error.toString()),
            );
          },
          loading: () {
            return const Center(child: Loader());
          },
        ));
  }
}
