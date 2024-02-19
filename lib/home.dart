import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/logic/sign_up/sign_up_logic_cubit.dart';
import 'package:jwt_decode/utils/preferences/local_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: LocalStorageUtils.fetchToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final profile = snapshot.data ?? {};
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             
             Text(data)
              
            ],
          );
        },
      );
  }
}
