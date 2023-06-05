import 'package:myapp/model/user.dart';
import 'package:myapp/providers/base_provider.dart';

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("Korisnici");

  @override
  User fromJson(data) {
    //TODO : implement fromJson
    return User();
  }
}
