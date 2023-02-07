class FilterCarsModel {
  List<CarsFilter>? cars;
  String? message;

  FilterCarsModel({this.cars, this.message});

  FilterCarsModel.fromJson(Map<String, dynamic> json) {
    if (json['cars'] != null) {
      cars = <CarsFilter>[];
      json['cars'].forEach((v) {
        cars!.add(new CarsFilter.fromJson(v));
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

class CarsFilter {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  List<String>? images;
  String? price;
  String? carModelId;
  String? brandId;
  String? companyId;
  String? createdAt;
  String? updatedAt;

  CarsFilter(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.descriptionAr,
      this.descriptionEn,
      this.images,
      this.price,
      this.carModelId,
      this.brandId,
      this.companyId,
      this.createdAt,
      this.updatedAt});

  CarsFilter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    images = json['images'].cast<String>();
    price = json['price'];
    carModelId = json['car_model_id'];
    brandId = json['brand_id'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['images'] = this.images;
    data['price'] = this.price;
    data['car_model_id'] = this.carModelId;
    data['brand_id'] = this.brandId;
    data['company_id'] = this.companyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
