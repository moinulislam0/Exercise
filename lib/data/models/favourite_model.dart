class FavouriteModel {
  bool? success;
  String? message;
  List<Data>? data;
  MetaData? metaData;

  FavouriteModel({this.success, this.message, this.data, this.metaData});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
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
    data['success'] = success;
    data['message'] = message;
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
  int? duration;
  String? level;
  String? createdAt;
  bool? isFavorite;
  String? thumbnailUrl;
  String? category;
  int? chaptersCount;

  Data(
      {this.id,
      this.title,
      this.duration,
      this.level,
      this.createdAt,
      this.isFavorite,
      this.thumbnailUrl,
      this.category,
      this.chaptersCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    duration = json['duration'];
    level = json['level']?.toString();
    createdAt = json['created_at'];
    isFavorite = json['is_favorite'];
    thumbnailUrl = json['thumbnail_url']?.toString();
    category = json['category']?.toString();
    chaptersCount = json['chapters_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['duration'] = duration;
    data['level'] = level;
    data['created_at'] = createdAt;
    data['is_favorite'] = isFavorite;
    data['thumbnail_url'] = thumbnailUrl;
    data['category'] = category;
    data['chapters_count'] = chaptersCount;
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
    search = json['search']?.toString();
    filter = json['filter'] != null ? Filter.fromJson(json['filter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['search'] = search;
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
    categoryId = json['category_id']?.toString();
    startDate = json['start_date']?.toString();
    endDate = json['end_date']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}
