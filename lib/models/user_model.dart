class UserModel {
  String name;
  String phone;
  String email;
  String uId;
  String imageProfile;
  String imageCover;
  String bio;
  bool isEmailVerified;

  UserModel({
    this.uId,
    this.email,
    this.phone,
    this.name,
    this.isEmailVerified,
    this.bio,
    this.imageCover,
    this.imageProfile,
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    imageCover = json['image_cover'];
    imageProfile = json['image_profile'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'image_cover' : imageCover,
      'image_profile' : imageProfile,
      'bio' : bio,
      'isEmailVerified' : isEmailVerified,
    };
  }

}
