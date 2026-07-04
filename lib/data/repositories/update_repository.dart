import 'dart:io';

import 'package:touralie33_fo222668a7688/data/sources/remote/update_api_service.dart';

class UpdateRepository {
  UpdateApiService resource ;
  UpdateRepository({required this.resource});
  Future<bool> updateUser({
    required String name,
    required String email,
    required String dateOfBirth,
    required num weight,
    required num height,
    required String gender,
    File? image,
  }) async {
    return await resource.updateUser(
      name: name,
      email: email,
      dateOfBirth: dateOfBirth,
      weight: weight,
      height: height,
      gender: gender,
      image: image,
    );
  }
}
