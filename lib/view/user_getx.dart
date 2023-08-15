import 'package:cubitbloc_setstate_practice/components/user_widget.dart';
import 'package:cubitbloc_setstate_practice/getx/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserGetx extends GetView<GetxCon> {
  const UserGetx({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Users'),
      ),
      body: Obx(
        () => ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.userModel.value.userInfoList.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.userModel.value.userInfoList.length) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return UserWidget(
              userInfo: controller.userModel.value.userInfoList[index],
            );
          },
        ),
      ),
    );
  }
}
