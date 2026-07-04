class PriscirbedModel {
  bool? success;
  String? message;
  List<PrescriptionData>? data;
  MetaData? metaData;

  PriscirbedModel({this.success, this.message, this.data, this.metaData});

  PriscirbedModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PrescriptionData>[];
      json['data'].forEach((v) {
        data!.add(PrescriptionData.fromJson(v));
      });
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
    if (metaData != null) {
      data['meta_data'] = metaData!.toJson();
    }
    return data;
  }
}

class PrescriptionData {
  String? id;
  String? title;
  String? thumbnailUrl;
  String? watchStatus;
  int? totalVideos;
  int? totalCompletedVideos;
  String? createdAt;

  PrescriptionData({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.watchStatus,
    this.totalVideos,
    this.totalCompletedVideos,
    this.createdAt,
  });

  PrescriptionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnailUrl = json['thumbnail_url'];
    watchStatus = json['watch_status'];
    totalVideos = json['total_videos'];
    totalCompletedVideos = json['total_completed_videos'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['thumbnail_url'] = thumbnailUrl;
    data['watch_status'] = watchStatus;
    data['total_videos'] = totalVideos;
    data['total_completed_videos'] = totalCompletedVideos;
    data['created_at'] = createdAt;
    return data;
  }
}

class MetaData {
  int? page;
  int? limit;
  int? total;
  String? search;

  MetaData({this.page, this.limit, this.total, this.search});

  MetaData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['search'] = search;
    return data;
  }
}