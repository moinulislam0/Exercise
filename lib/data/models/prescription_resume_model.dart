class PrescriptionResumeModel {
  bool? success;
  String? message;
  PrescriptionResumeData? data;

  PrescriptionResumeModel({this.success, this.message, this.data});

  PrescriptionResumeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? PrescriptionResumeData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PrescriptionResumeData {
  String? id;
  String? prescriptionId;
  String? videoId;
  String? title;
  int? duration;
  int? chapterCount;
  String? thumbnail;
  Instruction? instruction;
  String? watchStatus;
  bool? isCompleted;
  String? level;
  String? category;
  String? url;
  int? lastWatchPosition;
  int? watchProgress;
  String? progressMessage;
  List<VideoChapters>? videoChapters;

  PrescriptionResumeData({
    this.id,
    this.prescriptionId,
    this.videoId,
    this.title,
    this.duration,
    this.chapterCount,
    this.thumbnail,
    this.instruction,
    this.watchStatus,
    this.isCompleted,
    this.level,
    this.category,
    this.url,
    this.lastWatchPosition,
    this.watchProgress,
    this.progressMessage,
    this.videoChapters,
  });

  PrescriptionResumeData.fromJson(Map<String, dynamic> json) {
    prescriptionId =
        json['prescription_id']?.toString() ?? json['id']?.toString();
    videoId = json['video_id']?.toString();
    id = prescriptionId ?? videoId;
    title = json['title']?.toString() ?? json['video_title']?.toString();
    duration = json['duration'] ?? json['video_duration'];
    chapterCount = json['chapter_count'] ?? json['total_videos'];
    thumbnail = json['thumbnail']?.toString() ?? json['video_thumbnail']?.toString();
    instruction = json['instruction'] != null
        ? Instruction.fromJson(json['instruction'])
        : null;
    watchStatus = json['watch_status']?.toString();
    isCompleted = json['is_completed'];
    level = json['level']?.toString();
    category =
        json['category']?.toString() ?? json['prescription_title']?.toString();
    url = json['url']?.toString();
    lastWatchPosition = json['last_watch_position'];
    watchProgress = json['watch_progress'] ?? json['progress'];
    progressMessage = json['progress_message']?.toString();
    if (json['video_chapters'] != null) {
      videoChapters = <VideoChapters>[];
      for (final v in json['video_chapters']) {
        videoChapters!.add(VideoChapters.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['prescription_id'] = prescriptionId;
    data['video_id'] = videoId;
    data['title'] = title;
    data['duration'] = duration;
    data['chapter_count'] = chapterCount;
    data['thumbnail'] = thumbnail;
    if (instruction != null) {
      data['instruction'] = instruction!.toJson();
    }
    data['watch_status'] = watchStatus;
    data['is_completed'] = isCompleted;
    data['level'] = level;
    data['category'] = category;
    data['url'] = url;
    data['last_watch_position'] = lastWatchPosition;
    data['watch_progress'] = watchProgress;
    data['progress_message'] = progressMessage;
    if (videoChapters != null) {
      data['video_chapters'] = videoChapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Instruction {
  String? description;
  List<String>? points;

  Instruction({this.description, this.points});

  Instruction.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    points = json['points'] != null
        ? List<String>.from(json['points'] as List)
        : <String>[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['points'] = points;
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
    startTime = json['start_time']?.toString();
    endTime = json['end_time']?.toString();
    thumbnailUrl = json['thumbnail_url']?.toString();
    videoUrl = json['video_url']?.toString() ??
        json['url']?.toString() ??
        json['mp4_url']?.toString() ??
        json['mp4']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['thumbnail_url'] = thumbnailUrl;
    data['video_url'] = videoUrl;
    return data;
  }
}
