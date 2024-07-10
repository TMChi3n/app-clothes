class UpProReq {
  String? username;
  String? phoneNumber;
  String? address;
  String? gender;
  String? birthday;

  UpProReq({this.username, this.phoneNumber, this.address, this.gender, this.birthday});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.username != null) data['username'] = this.username;
    if (this.phoneNumber != null) data['phone_number'] = this.phoneNumber;
    if (this.address != null) data['address'] = this.address;
    if (this.gender != null) data['gender'] = this.gender;
    if (this.birthday != null) data['birthday'] = this.birthday;
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
