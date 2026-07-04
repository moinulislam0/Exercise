class PriscirbedDetailsModel {
  bool? success;
  String? message;
  Data? data;

  PriscirbedDetailsModel({this.success, this.message, this.data});

  PriscirbedDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? prescriptionId;
  String? title;
  String? description;
  int? duration;
  String? level;
  String? createdAt;
  bool? isFavorite;
  int? lastWatchPosition;
  bool? isCompleted;
  String? url;
  String? thumbnailUrl;
  String? category;
  List<VideoChapters>? videoChapters;

  Data({
    this.id,
    this.prescriptionId,
    this.title,
    this.description,
    this.duration,
    this.level,
    this.createdAt,
    this.isFavorite,
    this.lastWatchPosition,
    this.isCompleted,
    this.url,
    this.thumbnailUrl,
    this.category,
    this.videoChapters,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prescriptionId = json['prescription_id']?.toString();
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    level = json['level'];
    createdAt = json['created_at'];
    isFavorite = json['is_favorite'];
    lastWatchPosition = json['last_watch_position'];
    isCompleted = json['is_completed'];
    url = json['url'];
    thumbnailUrl = json['thumbnail_url'];
    category = json['category'];
    if (json['video_chapters'] != null) {
      videoChapters = <VideoChapters>[];
      json['video_chapters'].forEach((v) {
        videoChapters!.add(new VideoChapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prescription_id'] = this.prescriptionId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['level'] = this.level;
    data['created_at'] = this.createdAt;
    data['is_favorite'] = this.isFavorite;
    data['last_watch_position'] = this.lastWatchPosition;
    data['is_completed'] = this.isCompleted;
    data['url'] = this.url;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['category'] = this.category;
    if (this.videoChapters != null) {
      data['video_chapters'] = this.videoChapters!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class VideoChapters {
  String? id;
  String? title;
  String? startTime;
  String? endTime;
  String? thumbnailUrl;
  String? videoUrl;

  VideoChapters({
    this.id,
    this.title,
    this.startTime,
    this.endTime,
    this.thumbnailUrl,
    this.videoUrl,
  });

  VideoChapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    thumbnailUrl = json['thumbnail_url'];
    videoUrl =
        json['video_url']?.toString() ??
        json['url']?.toString() ??
        json['mp4_url']?.toString() ??
        json['mp4']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['video_url'] = this.videoUrl;
    return data;
  }
}
