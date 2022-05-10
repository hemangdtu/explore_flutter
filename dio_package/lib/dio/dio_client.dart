import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/posts.dart';

class DioClient{
  final Dio dio = Dio();
  static const baseURL = "https://jsonplaceholder.typicode.com";
  static const postsEndpoint = baseURL + "/todos";

  Future<Post> fetchPost(int postID) async
  {
    try{
      final response = await dio.get(postsEndpoint + "/$postID");
      debugPrint(response.toString());
      return Post.fromJson(response.data);
    }
    on DioError catch(e){
      debugPrint(e.response?.statusCode.toString());
      throw Exception("Failed to load post with ID $postID");
    }
  }
}