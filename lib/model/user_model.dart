import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int currentPage;
  final List<UserInfo> userInfoList;

  const UserModel({
    required this.currentPage,
    required this.userInfoList,
  });

  UserModel.init() : this(currentPage: 0, userInfoList: []);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        currentPage: (json['info']['page'] as int) + 1,
        userInfoList: json['results']
            .map<UserInfo>((item) => UserInfo.fromJson(item))
            .toList(),
      );

  UserModel copyWithFromJson(Map<String, dynamic> json) => UserModel(
        currentPage: (json['info']['page'] as int) + 1,
        userInfoList: userInfoList
          ..addAll(
            json['results']
                .map<UserInfo>((item) => UserInfo.fromJson(item))
                .toList(),
          ),
      );

  @override
  List<Object?> get props => [currentPage, userInfoList];
}

class UserInfo extends Equatable {
  final String name;
  final String email;
  final String userImage;
  final String phoneNumber;

  const UserInfo({
    required this.name,
    required this.email,
    required this.userImage,
    required this.phoneNumber,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        name: json['name']['first'] + json['name']['last'],
        email: json['email'],
        userImage: json['picture']['medium'],
        phoneNumber: json['cell'],
      );

  @override
  List<Object?> get props => [name, email, userImage, phoneNumber];
}
