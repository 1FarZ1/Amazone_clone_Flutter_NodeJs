import 'package:cloudinary_public/cloudinary_public.dart';

abstract class AddProductRepo {
  Future addProduct();
}

class AddProductRepoImpl implements AddProductRepo {
  @override
  Future addProduct() async {
    var _cloud = CloudinaryPublic("dcnwbszmt", "k10hhnqb");
    var res = await _cloud.uploadFile(CloudinaryFile.fromFile("",folder:""));
    res.secureUrl;
    throw UnimplementedError();
  }
}
