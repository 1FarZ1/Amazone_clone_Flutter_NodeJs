import 'package:amazon_clone/core/constant/constants.dart';
import 'package:amazon_clone/features/search/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common/loader.dart';
import '../../home/view/widgets/address_box.dart';
import 'widget/searched_product.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<ConsumerStatefulWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchSearchedProduct();
    });
  }

  fetchSearchedProduct() async {
    ref.read(searchControllerProvider.notifier).fetchSearchProducts();
  }

  void navigateToSearchScreen(String query) {
    GoRouter.of(context).push("/search");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pushReplacement("/home");
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
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
                        onFieldSubmitted: (val) {
                          ref
                              .read(searchControllerProvider.notifier)
                              .searchQuery = val;
                          navigateToSearchScreen(val);
                        },
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
        body: ref.watch(searchControllerProvider).when(
          data: (productList) {
            if (productList == null) {
              return const Center(child: Text(' looking for data'));
            }
            if (productList.isEmpty) {
              return const Center(child: Text('No data found'));
            }
            return Column(
              children: [
                const AddressBox(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push("/product-detaills",extra: productList[index]);
                        },
                        child: SearchedProduct(
                          product: productList[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text(error.toString()));
          },
          loading: () {
            return const Center(child: Loader());
          },
        ));
  }
}
