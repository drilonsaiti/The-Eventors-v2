import 'package:flutter/cupertino.dart';
import 'package:the_eventors/repository/UserRepository.dart';
import '../models/dto/RegisterDto.dart';
import '../models/dto/UserUsernameDto.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  List<UserUsernameDto> findUsername = [];
  login(String username, String password) {
    _userRepository.login(username, password);
    notifyListeners();
  }

  register(RegisterDto registerDto) {
    _userRepository.register(registerDto);
    notifyListeners();
  }

  findUserssByQuery(String query) async {
    findUsername = await _userRepository.findUsersByQuery(query);

    notifyListeners();
  }
}
