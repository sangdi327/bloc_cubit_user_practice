import 'package:cubitbloc_setstate_practice/components/user_widget.dart';
import 'package:cubitbloc_setstate_practice/cubit/cubit_copywith.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCopyWith extends StatefulWidget {
  const UserCopyWith({super.key});

  @override
  State<UserCopyWith> createState() => _UserCopyWithState();
}

class _UserCopyWithState extends State<UserCopyWith> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent - 200 <=
          scrollController.offset) {
        context.read<CubitCopyWith>().getUserInfoCopyWith();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Users'),
      ),
      body: BlocBuilder<CubitCopyWith, UserCopyWithState>(
          builder: (context, state) {
        switch (state.status) {
          case Status.init:
          case Status.loading:
          case Status.loaded:
            return ListView.builder(
              controller: scrollController,
              itemCount: state.userModel.userInfoList.length + 1,
              itemBuilder: (context, index) {
                if (index == state.userModel.userInfoList.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return UserWidget(
                    userInfo: state.userModel.userInfoList[index]);
              },
            );
          case Status.error:
            return const Center(
              child: Text('Error is occurred!'),
            );
        }
      }),
    );
  }
}
