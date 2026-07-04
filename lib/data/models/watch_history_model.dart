class WatchHistoryModel {
  final bool? success;
  final String? message;
  final List<WatchHistoryItem>? data;
  final MetaData? metaData;

  WatchHistoryModel({
    this.success,
    this.message,
    this.data,
    this.metaData,
  });

  factory WatchHistoryModel.fromJson(Map<String, dynamic> json) {
    return WatchHistoryModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<WatchHistoryItem>.from(
              json['data'].map((x) => WatchHistoryItem.fromJson(x)))
          : null,
      metaData: json['meta_data'] != null
          ? MetaData.fromJson(json['meta_data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((v) => v.toJson()).toList(),
      'meta_data': metaData?.toJson(),
    };
  }
}

class WatchHistoryItem {
  final String? id;
  final String? title;
  final int? duration;
  final String? level;
  final String? createdAt;
  final String? watchStatus;
  final bool? isCompleted;
  final int? lastPlayedPosition;
  final String? thumbnailUrl;
  final String? category;
  final int? chaptersCount;

  WatchHistoryItem({
    this.id,
    this.title,
    this.duration,
    this.level,
    this.createdAt,
    this.watchStatus,
    this.isCompleted,
    this.lastPlayedPosition,
    this.thumbnailUrl,
    this.category,
    this.chaptersCount,
  });

  factory WatchHistoryItem.fromJson(Map<String, dynamic> json) {
    return WatchHistoryItem(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      level: json['level'],
      createdAt: json['created_at'],
      watchStatus: json['watch_status'],
      isCompleted: json['is_completed'],
      lastPlayedPosition: json['last_played_position'],
      thumbnailUrl: json['thumbnail_url'],
      category: json['category'],
      chaptersCount: json['chapters_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'level': level,
      'created_at': createdAt,
      'watch_status': watchStatus,
      'is_completed': isCompleted,
      'last_played_position': lastPlayedPosition,
      'thumbnail_url': thumbnailUrl,
      'category': category,
      'chapters_count': chaptersCount,
    };
  }
}

class MetaData {
  final int? page;
  final int? limit;
  final int? total;
  final Map<String, dynamic>? filter;

  MetaData({this.page, this.limit, this.total, this.filter});

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      filter: json['filter'], // Simplified as Filter was empty
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'filter': filter,
    };
  }
}
