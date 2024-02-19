import 'package:flutter/material.dart';
import 'package:jwt_decode/model/jwt_token_response_mode.dart';
import 'package:jwt_decode/utils/preferences/local_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(LocalStorageUtils.userData().name.toString());
  }
}
