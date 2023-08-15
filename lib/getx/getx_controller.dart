import 'package:cubitbloc_setstate_practice/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxCon extends GetxController {
  Rx<UserModel> userModel = UserModel.init().obs;
  late Dio _dio;
  ScrollController scrollController = ScrollController();
  int nextPage = -1;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent - 200 <=
              scrollController.offset &&
          nextPage != userModel.value.currentPage) {
        nextPage = userModel.value.currentPage;
        getUserInfo();
      }
    });
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    var result = await _dio.get('api', queryParameters: {
      'results': 10,
      'seed': 'key',
      'page': userModel.value.currentPage,
    });
    await Future.delayed(const Duration(milliseconds: 500));
    userModel(userModel.value.copyWithFromJson(result.data));
  }
}
