class CompanyModel {
  List<Companies>? companies;
  String? message;

  CompanyModel({this.companies, this.message});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    if (json['companies'] != null) {
      companies = <Companies>[];
      json['companies'].forEach((v) {
        companies!.add(new Companies.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.companies != null) {
      data['companies'] = this.companies!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Companies {
  int? id;
  String? name;
  String? image;
  String? address;
  String? location;
  String? phone1;
  String? phone2;

  Companies(
      {this.id,
      this.name,
      this.image,
      this.address,
      this.location,
      this.phone1,
      this.phone2});

  Companies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    address = json['address'];
    location = json['location'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['address'] = this.address;
    data['location'] = this.location;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    return data;
  }
}
