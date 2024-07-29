import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/sign_in_controller.dart';
import 'package:task_manager/ui/screens/auth/email_verification_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import '../../utility/app_constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Email Address';
                        }
                        if (AppConstants.emailRegExp.hasMatch(value!) ==
                            false) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Email Address';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<SignInController>(
                      builder: (signInController) {
                        return Visibility(
                          visible: signInController.signInApiInProgress == false,
                          replacement: const CenteredProgressIndicator(),
                          child: ElevatedButton(
                            onPressed: _onTapNextButton,
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 36),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: _onTapForgotPassword,
                            child: const Text('Forgot Password?'),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.4,
                              ),
                              text: "Don't have an account? ",
                              children: [
                                TextSpan(
                                    text: 'Sign Up',
                                    style: const TextStyle(
                                      color: AppColors.themeColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _onTapSignUpButton),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    if (_formKey.currentState!.validate()) {
      final SignInController singInController = Get.find<SignInController>();
      final bool result = await singInController.signIn(
        _emailTEController.text.trim(),
        _passwordTEController.text,
      );
      if (result){
        Get.offAll(() => const MainBottomNavScreen());
      }
      else {
        if (mounted){
          showSnackBarMessage(context, singInController.errorMessage);
        }
      }
    }
  }

  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  void _onTapForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailVerificationScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
