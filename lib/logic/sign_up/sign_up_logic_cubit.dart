import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/home.dart';
import 'package:jwt_decode/model/jwt_token_response_mode.dart';
import 'package:jwt_decode/model/referesh_token_mode.dart';
import 'package:jwt_decode/model/verify_otp_mode..dart';
import 'package:jwt_decode/repo/send_otp_repo.dart';
import 'package:jwt_decode/utils/preferences/local_preferences.dart';
part 'sign_up_logic_state.dart';

class SignUpLogicCubit extends Cubit<SignUpLogicState> {
  SignUpLogicCubit() : super(SignUpLogicInitial());

  final _authrepo = AuthRepo();
  int groupId = 1703228300417;

  void sendOtp(String number, BuildContext context) async {
    var data = {"phoneNumber": number, "groupId": groupId};
    try {
      emit(SendOtpLoading());
      var response = await _authrepo.senOtp(data);
      response.fold((error) {
        emit(SendOtpError(error.message));
      }, (data) {
        emit(SendOtpLoaded());
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Send Otp Successfully")));
      });
    } catch (e) {
      emit(SendOtpError(e.toString()));
    }
  }

  void verifyOtp(
      {required String number,
      required int otp,
      required BuildContext context}) async {
    var data = {"phoneNumber": number, "otp": otp};
    try {
      emit(verifyOtpLoading());
      var response = await _authrepo.verifyOtp(data);
      response.fold((error) {
        emit(verifyOtpError(error.message));
      }, (data) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Verify Otp Successfully")));
        refreshToken(token: data.token.toString(), groupId: groupId);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      });
    } catch (e) {
      emit(verifyOtpError(e.toString()));
    }
  }

  void refreshToken({
    required String token,
    required int groupId,
  }) async {
    var data = {"token": token, "groupId": groupId};
    try {
      var response = await _authrepo.refreshToken(data);
      response.fold((error) {
        emit(verifyOtpError(error.message));
      }, (data) {
        LocalStorageUtils.saveUserDetails(token);
        print("refresh token is $token ");
      });
    } catch (e) {
      emit(verifyOtpError(e.toString()));
    }
  }

  void userProfile() async {
  try {
    var userData = await LocalStorageUtils.userData();

    emit(userProfileLoading());
    if (userData != null) {
      emit(userProfileLoaded(jwtmodel: userData));
      print("Token: ${userData.name}");
 
    } else {
    
      emit(userProfileError(error: "Error retrieving user data"));
    }
  } catch (e) {
    // Handle error case
    emit(verifyOtpError(e.toString()));
  }
}

}
