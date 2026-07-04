import 'package:flutter_riverpod/legacy.dart'; // Or just 'package:flutter_riverpod/flutter_riverpod.dart'
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/models/membership_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/member_ship_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/membership_api_service.dart';

class SubscriptionState {
  final bool isloading;
  final String? errorMessage;
  final MembershipModel? membershipModel;

  SubscriptionState({
    required this.isloading, 
    this.errorMessage, 
    this.membershipModel,
  });

  SubscriptionState copyWith({
    bool? isloading, 
    String? errorMessage, 
    MembershipModel? memberShip,
  }) {
    return SubscriptionState(
      isloading: isloading ?? this.isloading,
      errorMessage: errorMessage ?? this.errorMessage,
      membershipModel: memberShip ?? this.membershipModel,
    );
  }
}

class SubscriptionProvider extends StateNotifier<SubscriptionState> {
  final MemberShipRepository source;

  SubscriptionProvider({required this.source}) 
      : super(SubscriptionState(isloading: false));

  Future<bool> subscription() async {
    // 1. Set loading to true
    state = state.copyWith(isloading: true, errorMessage: null);
    
    try {
      final response = await source.membership();
      // 2. MUST assign the result back to state
      state = state.copyWith(isloading: false, memberShip: response);
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

final subscriptionProvider= StateNotifierProvider<SubscriptionProvider,SubscriptionState>((ref){
  return SubscriptionProvider(source: MemberShipRepository(resource: MembershipApiService(apiClient: ApiClient(),membershipModel: MembershipModel())));
});
