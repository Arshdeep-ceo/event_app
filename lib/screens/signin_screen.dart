import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import '../models/signin_model.dart';
import '../widgets/input_widget.dart';
import '../widgets/outline_button_widget.dart';
import '../widgets/solid_button_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginModel = Get.put(SignInModel());
    final formKey = GlobalKey<FormState>();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kprimaryColor2,
            Color(0xff140A08),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0, right: 25, left: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35.0, vertical: 50),
                    child: Text(
                      'Arsh',
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.sacramento(fontSize: 45, color: kwhite),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Text(
                            'Log In',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: kwhite),
                          ),
                          Divider(
                            color: kwhite,
                            thickness: 2,
                            endIndent: 280,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            InputWidget(
                              focusedBorderColor: ksecondaryColor,
                              fillColor: Colors.white,
                              controller: loginModel.emailController,
                              validator: loginModel.validateEmail,
                              hintText: 'email',
                              textColor: Colors.black,
                            ),
                            InputWidget(
                              focusedBorderColor: ksecondaryColor,
                              fillColor: Colors.white,
                              controller: loginModel.passwordController,
                              hintText: 'password',
                              validator: loginModel.validatePassword,
                              hideText: true,
                              textColor: Colors.black,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SolidButtonWidget(
                              iconData: Icons.arrow_forward,
                              color: Colors.white24,
                              buttonText: 'Login',
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await loginModel.signIn();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      OutlinedButtonWidget(
                        buttonText: 'Register',
                        color: kwhite,
                        onPressed: () {
                          loginModel.navigateToRegister();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        indent: 130,
                        endIndent: 130,
                        thickness: 2,
                        color: kwhite,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
