import 'package:touralie33_fo222668a7688/data/sources/remote/personalization_api_service.dart';

class PersonalizationRepository {
  final PersonalizationApiService remoteSource;

  PersonalizationRepository({required this.remoteSource});

  Future<Map<String, dynamic>> personalization() async {
    return remoteSource.personalization();
  }
}
