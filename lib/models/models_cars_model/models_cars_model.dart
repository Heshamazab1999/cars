class CarModelModel {
  List<Models>? models;
  String? message;

  CarModelModel({this.models, this.message});

  CarModelModel.fromJson(Map<String, dynamic> json) {
    if (json['models'] != null) {
      models = <Models>[];
      json['models'].forEach((v) {
        models!.add(new Models.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.models != null) {
      data['models'] = this.models!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Models {
  int? id;
  String? year;
  String? createdAt;
  String? updatedAt;

  Models({this.id, this.year, this.createdAt, this.updatedAt});

  Models.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
