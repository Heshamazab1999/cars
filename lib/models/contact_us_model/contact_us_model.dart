class ContactUSModel {
  List<BrandsContactUs>? brands;
  String? message;

  ContactUSModel({this.brands, this.message});

  ContactUSModel.fromJson(Map<String, dynamic> json) {
    if (json['brands'] != null) {
      brands = <BrandsContactUs>[];
      json['brands'].forEach((v) {
        brands!.add(new BrandsContactUs.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class BrandsContactUs {
  int? id;
  String? title;
  String? description;
  String? icon;

  BrandsContactUs({this.id, this.title, this.description, this.icon});

  BrandsContactUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}
