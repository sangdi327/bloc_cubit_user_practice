import 'package:bloc/bloc.dart';
import 'package:cubitbloc_setstate_practice/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class CubitExtends extends Cubit<UserExtendsState> {
  late Dio _dio;

  CubitExtends() : super(InitUserExtendsState()) {
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));

    getUserInfo();
  }
  Future<void> getUserInfo() async {
    try {
      if (state is LoadingUserExtendsState || state is ErrorUserExtendsState) {
        return;
      }
      emit(LoadingUserExtendsState(userModel: state.userModel));
      var result = await _dio.get('api', queryParameters: {
        'results': 10,
        'seed': 'key',
        'page': state.userModel.currentPage,
      });
      await Future.delayed(const Duration(milliseconds: 500));
      emit(LoadedUserExtendsState(
          userModel: state.userModel.copyWithFromJson(result.data)));
    } catch (e) {
      emit(
        ErrorUserExtendsState(
          userModel: state.userModel,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

abstract class UserExtendsState extends Equatable {
  final UserModel userModel;
  const UserExtendsState({required this.userModel});
}

class InitUserExtendsState extends UserExtendsState {
  InitUserExtendsState() : super(userModel: UserModel.init());

  @override
  List<Object?> get props => [userModel];
}

class LoadingUserExtendsState extends UserExtendsState {
  const LoadingUserExtendsState({required super.userModel});

  @override
  List<Object?> get props => [userModel];
}

class LoadedUserExtendsState extends UserExtendsState {
  const LoadedUserExtendsState({required super.userModel});

  @override
  List<Object?> get props => [userModel];
}

class ErrorUserExtendsState extends UserExtendsState {
  final String? errorMessage;
  const ErrorUserExtendsState({required super.userModel, this.errorMessage});

  @override
  List<Object?> get props => [userModel, errorMessage];
}
