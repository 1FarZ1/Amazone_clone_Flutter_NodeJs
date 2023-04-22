import 'dart:developer';
import 'dart:io';

import 'package:amazon_clone/core/api_service.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

import '../../../models/product.dart';

abstract class AddProductRepo {
  Future addProduct(
      {required token,
      required String name,
      required List<File> images,
      required quantity,
      required description,
      required category,
      required price});
}

class AddProductRepoImpl implements AddProductRepo {
  AddProductRepoImpl({required this.apiService});
  final ApiService apiService;
  @override
  Future addProduct(
      {required token,
      required String name,
      required List<File> images,
      required quantity,
      required description,
      required category,
      required price}) async {
    List<String> imageUrl = [];
    CloudinaryPublic cloud = CloudinaryPublic("dcnwbszmt", "k10hhnqb");
    for (var i = 0; i < images.length; i++) {
      var res = await cloud.uploadFile(CloudinaryFile.fromFile(images[i].path,folder:name));
      imageUrl.add(res.secureUrl);
    }

    Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrl,
        category: category,
        price: price);
    var res = await apiService.addProduct(token: token, product: product);
    log(res.toString());
  }
}
