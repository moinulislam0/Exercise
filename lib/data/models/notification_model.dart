class NotificationModel {
  bool? success;
  List<Data>? data;
  MetaData? metaData;

  NotificationModel({this.success, this.data, this.metaData});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      for (final v in json['data']) {
        data!.add(Data.fromJson(v));
      }
    }
    metaData = json['meta_data'] != null
        ? MetaData.fromJson(json['meta_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? description;
  String? type;
  String? createdAt;

  Data({this.id, this.title, this.description, this.type, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    title = json['title']?.toString();
    description = json['description']?.toString();
    type = json['type']?.toString();
    createdAt = json['created_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class MetaData {
  int? page;
  int? limit;
  int? total;

  MetaData({this.page, this.limit, this.total});

  MetaData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    return data;
  }
}
