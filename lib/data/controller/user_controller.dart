import 'package:fitness_mvp/data/DTO/user_info_response.dart';
import 'package:fitness_mvp/data/repository/user_repository.dart';

class UserController {

  final UserRepository userRepository;
  UserInfoResponse? userInfo;

  UserController({required this.userRepository});

  Future<void> getUserInfo() async{
    userInfo = await userRepository.getUserInfo();
  }

}