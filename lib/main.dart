import 'package:flutter/material.dart';
import 'package:jwt_decode/logic/sign_up/sign_up_logic_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/utils/preferences/local_preferences.dart';

void main() async {
  runApp(const MyApp());
  await LocalStorageUtils.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final mobileController = TextEditingController();
    final otpController = TextEditingController();
    return BlocProvider(
      create: (context) => SignUpLogicCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<SignUpLogicCubit, SignUpLogicState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      TextFormField(
                        controller: mobileController,
                        decoration: InputDecoration(
                          hintText: "Mobile number",
                          border: const OutlineInputBorder(),
                          suffixIcon: InkWell(
                            onTap: () {
                              context
                                  .read<SignUpLogicCubit>()
                                  .sendOtp(mobileController.text, context);
                            },
                            child: state is SendOtpLoading
                                ? const CircularProgressIndicator()
                                : const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: Icon(Icons.navigate_next),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: otpController,
                        decoration: InputDecoration(
                          hintText: "Enter otp",
                          border: const OutlineInputBorder(),
                          suffixIcon: InkWell(
                            onTap: () {
                              int otpValue =
                                  int.parse(otpController.text.trim());
                              context.read<SignUpLogicCubit>().verifyOtp(
                                  context: context,
                                  number: mobileController.text,
                                  otp: otpValue);
                            },
                            child: state is verifyOtpLoading
                                ? const CircularProgressIndicator()
                                : const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: Icon(Icons.navigate_next),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
          )),
    );
  }
}
