class UserInfoResponse {

  String username;
  String email;
  int totalWorkouts;

  UserInfoResponse({required this.username,required this.email, required this.totalWorkouts});

  factory UserInfoResponse.fromJson(Map<String,dynamic> json){
    return UserInfoResponse(username: json['username'], email: json['email'], totalWorkouts: json['totalWorkouts']);
  }

}