
class UserMdel {
final String userName;
final String email;
final String profileImageUrl;
final String? token;
final String? password;

UserMdel({
  required this.userName,
  required this.email,
  required this.profileImageUrl,
  this.token,
  this.password,
  
});
factory UserMdel.fromJson(Map<String,dynamic>json){
  return UserMdel(
    userName: json['userName'],
    email: json['email'],
    profileImageUrl: json['profileImageUrl'],
    token: json['token'],
    password: json['password'],
  );
}
Map<String,dynamic>toJson(){
  return {
    'userName':userName,
    'email':email,
    'profileImageUrl':profileImageUrl,
    'token':token,
    'password':password,

  };
}
}