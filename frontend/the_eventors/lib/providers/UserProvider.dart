import 'package:flutter/cupertino.dart';
import 'package:the_eventors/models/dto/UserProfileDto.dart';
import '../models/dto/RegisterDto.dart';
import '../models/dto/UserUsernameDto.dart';
import '../services/UserRepository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  List<UserUsernameDto> findUsername = [];
  List<UserUsernameDto> users = [];
  List<UserUsernameDto> myFollowing = [];
  List<UserUsernameDto> myFollowers = [];

  int countFollowing = 0;
  String checkBM = "false";
  String username = "";
  String email = "";
  String error = "";
  UserUsernameDto dto = UserUsernameDto(username: "", profileImage: "");
  UserProfileDto profile = UserProfileDto(
      username: "",
      profileImage: "",
      fullName: "",
      bio: "",
      countEvents: 0,
      countFollowers: 0,
      countFollowing: 0);

  bool isFollowing = false;
  login(String username, String password) async {
    error = await _userRepository.login(username, password);
    notifyListeners();
  }

  register(RegisterDto registerDto) async {
    error = await _userRepository.register(registerDto);
    notifyListeners();
  }

  getDiscoverUsers() async {
    users = await _userRepository.getDiscoverUsers();

    notifyListeners();
  }

  getUser() async {
    dto = await _userRepository.findUserByQuery();
    notifyListeners();
  }

  getCountFollowing() async {
    countFollowing = await _userRepository.countFollwoing();

    notifyListeners();
  }

  findUserssByQuery(String query) async {
    findUsername = await _userRepository.findUsersByQuery(query);

    notifyListeners();
  }

  addBookmark(int id) {
    _userRepository.addBookmark(id);
    notifyListeners();
  }

  checkBookmark(int id) async {
    checkBM = await _userRepository.checkBookmark(id);
    notifyListeners();
  }

  removeBookmark(int id) {
    _userRepository.removeBookmark(id);
    notifyListeners();
  }

  getUsername() async {
    username = await _userRepository.getUsername();
    notifyListeners();
  }

  getEmail() async {
    email = await _userRepository.getEmail();
    notifyListeners();
  }

  getUserByUsername(String username) async {
    profile = await _userRepository.getProfile(username);
    notifyListeners();
  }

  checkIsFollowing(String username) async {
    isFollowing = await _userRepository.checkIsFollowing(username);
    notifyListeners();
  }

  changePassword(
      String oldPass, String newPass, String rPass, String username) async {
    error =
        await _userRepository.changePassword(oldPass, newPass, rPass, username);
    notifyListeners();
  }

  changeUsername(String pass, String newUsername) async {
    error = await _userRepository.changeUsername(pass, newUsername);
    notifyListeners();
  }

  void logout() {
    _userRepository.logout();
    notifyListeners();
  }

  follow(String username) {
    _userRepository.follow(username);
    notifyListeners();
  }

  unfollow(String username) {
    _userRepository.unfollow(username);
    notifyListeners();
  }

  void addProfileImage(String base64encode) {
    _userRepository.addProfileImage(base64encode);
  }

  void removeProfileImage() {
    _userRepository.removeProfileImage();
  }

  void changeEmail(String email, String password, String verifyCode) async {
    error = await _userRepository.changeEmail(email, password, verifyCode);
    print("PROVider " + error);
    notifyListeners();
  }

  void sendVerification(String email) async {
    error = await _userRepository.sendVerification(email);
    notifyListeners();
  }

  void forgotPassword(String email, String password, String repeatPassword,
      String verifyCode) async {
    error = await _userRepository.forgotPassword(
        email, password, repeatPassword, verifyCode);
    notifyListeners();
  }

  void updateProfile(String fullName, String bio) {
    _userRepository.updateProfile(fullName, bio);
    notifyListeners();
  }

  void deleteAccount() {
    _userRepository.deleteAccount();
    notifyListeners();
  }

  getMyFollowing() async {
    myFollowing = await _userRepository.getAllMyFollowing();
    print("PROVIDER ");
    print(myFollowing);
  }

  getMyFollowers() async {
    myFollowers = await _userRepository.getAllMyFollowers();
  }
}
