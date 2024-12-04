
class UserData {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? address;
  int? activationCode;
  bool? isVerified;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? image;

  UserData(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.password,
        this.address,
        this.activationCode,
        this.isVerified,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.image,
      });

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    address = json['address'];
    activationCode = json['activationCode'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    image = json['image'];
  }

  String get fullName => "${firstName ?? ""} ${lastName ?? ""}";
}