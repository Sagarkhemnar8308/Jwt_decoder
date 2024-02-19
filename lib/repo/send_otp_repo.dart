import 'package:dartz/dartz.dart';
import 'package:jwt_decode/model/referesh_token_mode.dart';
import 'package:jwt_decode/model/send_otp_response.dart';
import 'package:jwt_decode/model/verify_otp_mode..dart';
import 'package:jwt_decode/utils/api/api_exceptions.dart';
import 'package:jwt_decode/utils/api/api_manager.dart';
import 'package:jwt_decode/utils/api/failure.dart';

class AuthRepo {
  final _apiManager = ApiManager();

  Future<Either<Failure, SendOtpResponse>> senOtp(Map data) async {
    try {
      var jsonResponse = await _apiManager.post(
          "https://gxppcdmn7h.execute-api.ap-south-1.amazonaws.com/authgw/sendotp",
          data);
      var response = SendOtpResponse.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(Map data) async {
    try {
      var jsonResponse = await _apiManager.post(
          "https://4r4iwhot12.execute-api.ap-south-1.amazonaws.com/auth/auth/validateOtp/",
          data);
      var response = VerifyOtpResponse.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }

    Future<Either<Failure, RefreshTokenResponseModel>> refreshToken(Map data) async {
    try {
      var jsonResponse = await _apiManager.post(
          "https://gxppcdmn7h.execute-api.ap-south-1.amazonaws.com//authgw/refresh-token",
          data);
      var response = RefreshTokenResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }
}
