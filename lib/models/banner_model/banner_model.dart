class BannerModel {
  String? message;
  List<Banners>? banners;

  BannerModel({this.message, this.banners});

  BannerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  int? id;
  String? banner;
  String? createdAt;
  String? updatedAt;

  Banners({this.id, this.banner, this.createdAt, this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
