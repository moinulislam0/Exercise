class MembershipModel {
  bool? success;
  String? message;
  List<Data>? data;

  MembershipModel({this.success, this.message, this.data});

  MembershipModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  double? price;
  String? badge;
  String? period;
  List<String>? features;
  String? description;

  Data(
      {this.id,
      this.title,
      this.price,
      this.badge,
      this.period,
      this.features,
      this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = (json['price'] as num?)?.toDouble();
    badge = json['badge']?.toString();
    period = json['period']?.toString();
    features = (json['features'] as List?)
        ?.map((item) => item.toString())
        .toList();
    description = json['description']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['badge'] = this.badge;
    data['period'] = this.period;
    data['features'] = this.features;
    data['description'] = this.description;
    return data;
  }
}
