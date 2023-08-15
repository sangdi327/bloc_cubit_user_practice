import 'package:cubitbloc_setstate_practice/cubit/cubit_copywith.dart';
import 'package:cubitbloc_setstate_practice/cubit/cubit_extends.dart';
import 'package:cubitbloc_setstate_practice/getx/getx_controller.dart';
import 'package:cubitbloc_setstate_practice/view/randomuser.dart';
import 'package:cubitbloc_setstate_practice/view/user_cubitcopywith.dart';
import 'package:cubitbloc_setstate_practice/view/user_cubitextends.dart';
import 'package:cubitbloc_setstate_practice/view/user_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RandomUser(),
                  ),
                );
              },
              child: const Text('Setstate home'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.put(GetxCon());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserGetx(),
                  ),
                );
              },
              child: const Text('Getx home'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => CubitExtends(),
                      child: const UserExtends(),
                    ),
                  ),
                );
              },
              child: const Text('Cubit extends home'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => CubitCopyWith(),
                      child: const UserCopyWith(),
                    ),
                  ),
                );
              },
              child: const Text('Cubit copywith home'),
            ),
          ],
        ),
      ),
    );
  }
}
