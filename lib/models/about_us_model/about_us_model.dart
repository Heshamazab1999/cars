class AboutUSModel {
  List<BrandsAboutUs>? brands;
  String? message;

  AboutUSModel({this.brands, this.message});

  AboutUSModel.fromJson(Map<String, dynamic> json) {
    if (json['brands'] != null) {
      brands = <BrandsAboutUs>[];
      json['brands'].forEach((v) {
        brands!.add(new BrandsAboutUs.fromJson(v));
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

class BrandsAboutUs {
  int? id;
  String? title;
  String? description;

  BrandsAboutUs({this.id, this.title, this.description});

  BrandsAboutUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
