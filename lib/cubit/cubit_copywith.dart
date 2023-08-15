import 'package:cubitbloc_setstate_practice/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitCopyWith extends Cubit<UserCopyWithState> {
  late Dio _dio;
  CubitCopyWith()
      : super(
          UserCopyWithState(status: Status.init, userModel: UserModel.init()),
        ) {
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    getUserInfoCopyWith();
  }

  Future<void> getUserInfoCopyWith() async {
    try {
      if (state.status == Status.loading || state.status == Status.error) {
        return;
      }
      emit(state.copyWith(status: Status.loading, userModel: state.userModel));
      var result = await _dio.get('api', queryParameters: {
        'results': 10,
        'seed': 'key',
        'page': state.userModel.currentPage,
      });
      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        state.copyWith(
          status: Status.loaded,
          userModel: state.userModel.copyWithFromJson(result.data),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          userModel: state.userModel,
          errorMessage: e.toString(),
        ),
      );
    }
    getUserInfoCopyWith();
  }
}

enum Status {
  init,
  loading,
  loaded,
  error,
}

class UserCopyWithState extends Equatable {
  final Status status;
  final UserModel userModel;
  final String? errorMessage;

  const UserCopyWithState({
    required this.status,
    required this.userModel,
    this.errorMessage,
  });

  UserCopyWithState copyWith({
    Status? status,
    UserModel? userModel,
    String? errorMessage,
  }) {
    return UserCopyWithState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, userModel, errorMessage];
}
