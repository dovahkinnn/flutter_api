import 'dart:async';

import 'package:flutterweb/models/user.dart';
import 'package:flutterweb/services/users_service.dart';

class UserBLoC {
  Stream<List<User>> usersList() async* {
    yield* Stream.periodic(Duration(milliseconds: 10), (_) async {
      return await UserService.browse();
    }).asyncMap((event) async => await event);
  }


}
