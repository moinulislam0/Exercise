import 'package:touralie33_fo222668a7688/data/sources/remote/library_progress_api_service.dart';

class LibraryProgressRepository {
  final LibraryProgressApiService resource;

  LibraryProgressRepository({required this.resource});

  Future<bool> syncProgress({
    required String id,
    required int lastWatchPositionSeconds,
    required bool isCompleted,
    String? prescriptionId,
  }) async {
    return resource.syncProgress(
      id: id,
      lastWatchPositionSeconds: lastWatchPositionSeconds,
      isCompleted: isCompleted,
      prescriptionId: prescriptionId,
    );
  }
}
