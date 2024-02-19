import 'dart:developer';
import 'package:jwt_decode/model/jwt_token_response_mode.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../models/jwt_token_response_model/jwt_token_response_model.dart';

class LocalStorageUtils {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static JwtTokenResponseModel get tokenResponseModel => userData();

  static Future<void> saveUserDetails(String token) async {
    await instance.setString("token", token);
    log("Token saved! $token");
    print("token saved " + token);
  }

  static Future<String?> fetchToken() async {
    final token = instance.getString('token') ?? '';

    if (token.isEmpty) {
      return "";
    }

    return token;
  }

  static JwtTokenResponseModel userData() {
    final token = instance.getString('token') ?? "";
    var userData = JwtDecoder.decode(token);
    var userDecoded = JwtTokenResponseModel.fromJson(userData);

    print("userDecode $userDecoded");
    return userDecoded;
  }
}
