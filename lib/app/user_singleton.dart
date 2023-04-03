class UserSingleton {
  static final UserSingleton _singleton = UserSingleton._internal();
  late String userId;
  late String userToken;
  factory UserSingleton() {
    return _singleton;
  }

  UserSingleton._internal();
}
