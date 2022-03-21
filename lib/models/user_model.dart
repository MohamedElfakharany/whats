class UserModel {
  String name;
  String phone;
  String email;
  String uId;
  bool isEmailVerified;

  UserModel({
    this.uId,
    this.email,
    this.phone,
    this.name,
    this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'isEmailVerified' : isEmailVerified,
    };
  }

}
