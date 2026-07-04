import 'package:touralie33_fo222668a7688/data/sources/remote/change_password_api_service.dart';

class ChangePasswordRepository {
  final ChangePasswordApiService resource;
  ChangePasswordRepository({required this.resource});

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return resource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
