import 'package:cubitbloc_setstate_practice/components/user_widget.dart';
import 'package:cubitbloc_setstate_practice/cubit/cubit_extends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserExtends extends StatefulWidget {
  const UserExtends({super.key});

  @override
  State<UserExtends> createState() => _UserExtendsState();
}

class _UserExtendsState extends State<UserExtends> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent - 200 <=
          scrollController.offset) {
        context.read<CubitExtends>().getUserInfo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Users'),
      ),
      body: BlocBuilder<CubitExtends, UserExtendsState>(
          builder: (context, state) {
        if (state is ErrorUserExtendsState) {
          return const Center(
            child: Text('Error is occurred!'),
          );
        }
        if (state is LoadingUserExtendsState ||
            state is LoadedUserExtendsState) {
          return ListView.builder(
            controller: scrollController,
            itemCount: state.userModel.userInfoList.length + 1,
            itemBuilder: (context, index) {
              if (index == state.userModel.userInfoList.length) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return UserWidget(userInfo: state.userModel.userInfoList[index]);
            },
          );
        }
        return Container();
      }),
    );
  }
}
