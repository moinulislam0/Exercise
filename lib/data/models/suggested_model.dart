class SuggestedModel {
  bool? success;
  String? message;
  List<Data>? data;
  MetaData? metaData;

  SuggestedModel({this.success, this.message, this.data, this.metaData});

  SuggestedModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    metaData = json['meta_data'] != null
        ? new MetaData.fromJson(json['meta_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
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
  String? thumbnailUrl;
  String? category;
  int? chaptersCount;
  String? createdAt;
  int? duration;
  String? level;
  bool? isFavorite;

  Data(
      {this.id,
      this.title,
      this.thumbnailUrl,
      this.category,
      this.chaptersCount,
      this.createdAt,
      this.duration,
      this.level,
      this.isFavorite});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnailUrl = json['thumbnail_url'];
    category = json['category'];
    chaptersCount = json['chapters_count'];
    createdAt = json['created_at'];
    duration = json['duration'];
    level = json['level'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['category'] = this.category;
    data['chapters_count'] = this.chaptersCount;
    data['created_at'] = this.createdAt;
    data['duration'] = this.duration;
    data['level'] = this.level;
    data['is_favorite'] = this.isFavorite;
    return data;
  }
}

class MetaData {
  int? page;
  int? limit;
  int? total;
  String? search;
  Filter? filter;

  MetaData({this.page, this.limit, this.total, this.search, this.filter});

  MetaData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    search = json['search'];
    filter =
        json['filter'] != null ? new Filter.fromJson(json['filter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['search'] = this.search;
    if (this.filter != null) {
      data['filter'] = this.filter!.toJson();
    }
    return data;
  }
}

class Filter {
  String? categoryId;
  String? startDate;
  String? endDate;

  Filter({this.categoryId, this.startDate, this.endDate});

  Filter.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
