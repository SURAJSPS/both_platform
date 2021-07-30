

class UserDataModel {
  

  String? email;
  String? password;
  String? image;
  String? name;
  String? phone;

  UserDataModel(
      { this.name, this.email, this.phone, this.image, this.password});

  static UserDataModel fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      image: map['image'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'password': password,
    };
    
    return map;
  }
}


