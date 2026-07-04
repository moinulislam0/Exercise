class PrescriptionDetialsModel {
  bool? success;
  String? message;
  Data? data;

  PrescriptionDetialsModel({this.success, this.message, this.data});

  PrescriptionDetialsModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? createdAt;
  String? lastPlayedVideoId;
  List<Videos>? videos;

  Data(
      {this.id,
      this.title,
      this.createdAt,
      this.lastPlayedVideoId,
      this.videos});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    lastPlayedVideoId = json['last_played_video_id'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['last_played_video_id'] = this.lastPlayedVideoId;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  String? id;
  String? reps;
  String? sets;
  String? weight;
  String? note;
  String? title;
  String? description;
  String? url;
  String? thumbnailUrl;
  String? category;
  int? lastPlayedPosition;
  bool? isFavorite;
  bool? isCompleted;

  Videos(
      {this.id,
      this.reps,
      this.sets,
      this.weight,
      this.note,
      this.title,
      this.description,
      this.url,
      this.thumbnailUrl,
      this.category,
      this.lastPlayedPosition,
      this.isFavorite,
      this.isCompleted});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reps = json['reps'];
    sets = json['sets'];
    weight = json['weight'];
    note = json['note'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    thumbnailUrl = json['thumbnail_url'];
    category = json['category'];
    lastPlayedPosition = json['last_played_position'];
    isFavorite = json['is_favorite'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reps'] = this.reps;
    data['sets'] = this.sets;
    data['weight'] = this.weight;
    data['note'] = this.note;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['category'] = this.category;
    data['last_played_position'] = this.lastPlayedPosition;
    data['is_favorite'] = this.isFavorite;
    data['is_completed'] = this.isCompleted;
    return data;
  }
}
