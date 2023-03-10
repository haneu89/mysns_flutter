import 'dart:io';

import 'package:get/get.dart';
import 'package:mysns/src/controller/user_controller.dart';

import '../shared/global.dart';

class FeedRepository extends GetConnect {
  final userController = Get.put(UserController());

  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.API_ROOT;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }

  Future<List?> feedIndex() async {
    Response response = await get(
      "/api/feed",
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> fileUpload(File image, String filename) async {
    Response response = await post(
      '/file/upload',
      FormData({
        'file': MultipartFile(image, filename: filename),
      }),
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> feedCreate(String content, int? imageId) async {
    Response response = await post(
      "/api/feed",
      {'content': content, "image_id": imageId},
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> feedUpdate(int id, String content) async {
    Response response = await put(
      "/api/feed/$id",
      {'content': content},
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> feedDelete(int id) async {
    Response response = await delete(
      "/api/feed/$id",
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> feedShow(int id) async {
    Response response = await get(
      "/api/feed/$id",
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }
}
