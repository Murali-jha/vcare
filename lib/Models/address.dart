class AddressModel {
  String name;
  String phoneNumber;
  String flatNumber;
  String city;
  String state;
  String pincode;
  String semester;
  String date;

  AddressModel(
      {this.name,
        this.phoneNumber,
        this.flatNumber,
        this.city,
        this.state,
        this.semester,
        this.date,
        this.pincode});

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    flatNumber = json['flatNumber'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    semester = json['semester'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['flatNumber'] = this.flatNumber;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['semester'] = this.semester;
    data['date'] = this.date;
    return data;
  }
}
