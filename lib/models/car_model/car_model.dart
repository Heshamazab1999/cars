class CarModel {
  List<Cars>? cars;
  String? message;

  CarModel({this.cars, this.message});

  CarModel.fromJson(Map<String, dynamic> json) {
    if (json['cars'] != null) {
      cars = <Cars>[];
      json['cars'].forEach((v) {
        cars!.add(new Cars.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cars != null) {
      data['cars'] = this.cars!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Cars {
  int? id;
  String? name;
  String? description;
  List<String>? images;
  String? price;
  String? carModelId;
  String? brandId;
  String? companyId;
  List<Colors>? colors;
  Companies? companies;
  Companies? brands;
  Models? models;

  Cars(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.price,
      this.carModelId,
      this.brandId,
      this.companyId,
      this.colors,
      this.companies,
      this.brands,
      this.models});

  Cars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    price = json['price'];
    carModelId = json['car_model_id'];
    brandId = json['brand_id'];
    companyId = json['company_id'];
    if (json['colors'] != null) {
      colors = <Colors>[];
      json['colors'].forEach((v) {
        colors!.add(new Colors.fromJson(v));
      });
    }
    companies = json['companies'] != null
        ? new Companies.fromJson(json['companies'])
        : null;
    brands =
        json['brands'] != null ? new Companies.fromJson(json['brands']) : null;
    models =
        json['models'] != null ? new Models.fromJson(json['models']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    data['price'] = this.price;
    data['car_model_id'] = this.carModelId;
    data['brand_id'] = this.brandId;
    data['company_id'] = this.companyId;
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    if (this.companies != null) {
      data['companies'] = this.companies!.toJson();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.toJson();
    }
    if (this.models != null) {
      data['models'] = this.models!.toJson();
    }
    return data;
  }
}

class Colors {
  int? id;
  String? name;
  String? value;

  Colors({this.id, this.name, this.value});

  Colors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Companies {
  int? id;
  String? name;

  Companies({this.id, this.name});

  Companies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Models {
  int? id;
  String? year;

  Models({this.id, this.year});

  Models.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    return data;
  }
}
