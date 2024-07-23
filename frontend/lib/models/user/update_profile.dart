class UpProReq {
  String? username;
  String? phoneNumber;
  String? address;
  String? gender;
  String? birthday;

<<<<<<< HEAD
  UpProReq({this.username, this.phoneNumber, this.address, this.gender, this.birthday});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.username != null) data['username'] = this.username;
    if (this.phoneNumber != null) data['phone_number'] = this.phoneNumber;
    if (this.address != null) data['address'] = this.address;
    if (this.gender != null) data['gender'] = this.gender;
    if (this.birthday != null) data['birthday'] = this.birthday;
=======
  UpProReq(
      {this.username,
      this.phoneNumber,
      this.address,
      this.gender,
      this.birthday});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (username != null) data['username'] = username;
    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (address != null) data['address'] = address;
    if (gender != null) data['gender'] = gender;
    if (birthday != null) data['birthday'] = birthday;
>>>>>>> main
    return data;
  }

  factory UpProReq.fromMap(Map<String, dynamic> map) {
    return UpProReq(
      username: map['username'],
      phoneNumber: map['phone_number'],
      address: map['address'],
      gender: map['gender'],
      birthday: map['birthday'],
    );
  }
}
