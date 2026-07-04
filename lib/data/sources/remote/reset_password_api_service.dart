import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';

class ResetPasswordApiService {
  ApiClient apiClient;
  ResetPasswordApiService({required this.apiClient});
  Future<bool>resetPass({required String email,required String pass,required String token})async{
    try{
      final body = {'email':email,'token':token,'password':pass};
      final response  = await apiClient.postRequest(endpoints: ApiEndpoints.resetPassWord,body: body);
      if(response['success']== true || response['success']==true){
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      throw Exception(ErrorHandle.formatErrorMessage(e));
    }
  }
}
