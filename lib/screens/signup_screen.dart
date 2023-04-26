import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import '../models/signup_model.dart';
import '../widgets/input_widget.dart';
import '../widgets/outline_button_widget.dart';
import '../widgets/solid_button_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerModel = Get.put(SignUpModel());
    // final authenticationModel = Get.put(AuthenticationModel());

    final formKey = GlobalKey<FormState>();
    return Container(
      // decoration: const BoxDecoration(
      // gradient: LinearGradient(
      //   begin: Alignment.topCenter,
      //   end: Alignment.bottomCenter,
      //   colors: [
      //     kprimaryColor,
      //     Color.fromARGB(255, 255, 65, 129),
      //   ],
      // ),
      // ),
      decoration: kscaffoldGradient,
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
                        horizontal: 25.0, vertical: 40),
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
                        children: [
                          Text(
                            'Sign Up',
                            style: Get.textTheme.headlineMedium!.copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: kwhite),
                          ),
                          const Divider(
                            color: kwhite,
                            thickness: 2,
                            endIndent: 265,
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
                            // InputWidget(
                            //   focusedBorderColor: ksecondaryColor,
                            //   fillColor: Colors.white,
                            //   controller:
                            //       registerModel.sponsorEditingController,
                            //   hintText: 'sponsor',
                            //   validator: registerModel.validateSponsor,
                            //   textColor: Colors.black,
                            // ),
                            InputWidget(
                              focusedBorderColor: ksecondaryColor,
                              fillColor: kwhite,
                              controller:
                                  registerModel.fullNameEditingController,
                              hintText: 'full name',
                              validator: registerModel.validateFullName,
                              textColor: kblack,
                            ),
                            InputWidget(
                              focusedBorderColor: ksecondaryColor,
                              fillColor: kwhite,
                              controller:
                                  registerModel.usernameEditingController,
                              hintText: 'username',
                              validator: registerModel.validateUsername,
                              textColor: kblack,
                            ),
                            InputWidget(
                              focusedBorderColor: ksecondaryColor,
                              fillColor: kwhite,
                              controller: registerModel.emailEditingController,
                              hintText: 'email',
                              validator: registerModel.validateEmail,
                              textColor: kblack,
                            ),
                            InputWidget(
                              focusedBorderColor: ksecondaryColor,
                              fillColor: kwhite,
                              controller:
                                  registerModel.passwordEditingController,
                              hintText: 'password',
                              hideText: true,
                              validator: registerModel.validatePassword,
                              textColor: kblack,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SolidButtonWidget(
                        iconData: Icons.arrow_forward,
                        color: Colors.white24,
                        buttonText: 'Register',
                        onPressed: () async {
                          await registerModel.checkUsername();
                          if (formKey.currentState!.validate()) {
                            await registerModel.signUp();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      OutlinedButtonWidget(
                        buttonText: 'Login',
                        color: kwhite,
                        onPressed: () {
                          registerModel.navigateToLogin();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        indent: 130,
                        endIndent: 130,
                        thickness: 2,
                        color: Colors.black,
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
