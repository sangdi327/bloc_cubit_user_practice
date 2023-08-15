import 'package:cubitbloc_setstate_practice/components/user_widget.dart';
import 'package:cubitbloc_setstate_practice/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RandomUser extends StatefulWidget {
  const RandomUser({super.key});

  @override
  State<RandomUser> createState() => _RandomUserState();
}

class _RandomUserState extends State<RandomUser> {
  late Dio _dio;
  late UserModel userModel;
  int nextPage = -1;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    userModel = UserModel(currentPage: 0, userInfoList: []);
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent - 200 <=
              scrollController.offset &&
          nextPage != userModel.currentPage) {
        nextPage = userModel.currentPage;
        setState(() {});
      }
    });
  }

  Future<UserModel> getUserInfo() async {
    var result = await _dio.get(
      'api',
      queryParameters: {
        'results': 10,
        'seed': 'key',
        'page': userModel.currentPage,
      },
    );
    await Future.delayed(const Duration(milliseconds: 500));
    userModel = userModel.copyWithFromJson(result.data);
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Users'),
      ),
      body: FutureBuilder<UserModel>(
          future: getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error occurred!'),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                controller: scrollController,
                itemCount: snapshot.data!.userInfoList.length + 1,
                itemBuilder: (context, index) {
                  if (index == snapshot.data!.userInfoList.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return UserWidget(
                    userInfo: snapshot.data!.userInfoList[index],
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
