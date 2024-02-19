// ignore_for_file: camel_case_types, must_be_immutable

part of 'sign_up_logic_cubit.dart';

@immutable
sealed class SignUpLogicState {
JwtTokenResponseModel? jwtmodel;
SignUpLogicState({this.jwtmodel});
}

final class SignUpLogicInitial extends SignUpLogicState {}

class SendOtpLoading extends SignUpLogicState {

}

class SendOtpLoaded extends  SignUpLogicState {

}

class SendOtpError extends SignUpLogicState {
String? errorMessage;
SendOtpError(errorMessage);
}

class verifyOtpLoading extends  SignUpLogicState{}
class verifyOtpLoaded extends  SignUpLogicState{

}
class verifyOtpError extends  SignUpLogicState{
String? errorMessage;
verifyOtpError(errorMessage);
}

// ignore: must_be_immutable
class userProfileLoading extends  SignUpLogicState{
  
}

class userProfileLoaded extends  SignUpLogicState{
  userProfileLoaded({super.jwtmodel});
}
class userProfileError extends  SignUpLogicState{
  String? error;
  userProfileError({this.error});
}