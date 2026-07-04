import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/memeber_ship_id_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/memberShip_id_api_service.dart';

class GetInTouchState {
  final bool isloading;
  final String? errormessage;
  GetInTouchState({required this.isloading, this.errormessage});
  GetInTouchState copyWith({bool? isloading, String? errorMessage}) {
    return GetInTouchState(
      isloading: isloading ?? this.isloading,
      errormessage: errorMessage ?? this.errormessage,
    );
  }
}

class GetInTouchProvider extends StateNotifier<GetInTouchState> {
  final MemeberShipIdRepository source;

  GetInTouchProvider({required this.source})
      : super(GetInTouchState(isloading: false));

  Future<bool> getIntouch({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    state = state.copyWith(isloading: true, errorMessage: null);

    try {
      await source.memberShipId(
        id: id,
        name: name,
        email: email,
        phone: phone,
        message: message,
      );

      state = state.copyWith(isloading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isloading: false,
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
      return false;
    }
  }
}
final getInTouchProvider = StateNotifierProvider<GetInTouchProvider, GetInTouchState>((ref) {
  return GetInTouchProvider(
    source: MemeberShipIdRepository(
      resource: MembershipIdApiService(apiClient: ApiClient()),
    ),
  );
});
