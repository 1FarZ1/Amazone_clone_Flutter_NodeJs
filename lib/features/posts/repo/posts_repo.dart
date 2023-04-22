import 'dart:developer';

import '../../../core/api_service.dart';

abstract class PostsRepo {
  Future getPosts({required String token});
  Future deletePosts({required String token,required  id});

}

class PostsRepoImpl implements PostsRepo {
  PostsRepoImpl({required this.apiService});
  final ApiService apiService;
  @override
  Future getPosts({required  token}) async {
    try {
      var res = await apiService.getPosts(token: token);
      return res;
    } catch (e) {
      print(e);
    }
  }
  
  @override
  Future deletePosts({required String token, required id}) async{
        try {
      var res = await apiService.deletePost(token: token,id:id);
      return res;
    } catch (e) {
      print(e);
    }
  }
}
