import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
   final TextEditingController _passwordTEController = TextEditingController();
   final TextEditingController _confirmPasswordTEController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Minimum length of password should be more than 6 letters, with combination of numbers and letters',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),

                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _confirmPasswordTEController,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),


                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onTapConfirmButton,
                    child: const Text('Confirm'),
                  ),

                  const SizedBox(height: 36),
                  Center(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.4,
                            ),
                            text: "Have account? ",
                            children: [
                              TextSpan(
                                  text: 'Sign In',
                                  style: const TextStyle(
                                    color: AppColors.themeColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        _onTapSignInButton),
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
    );
  }

  void _onTapSignInButton() {
    //Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
          (route) => false,
    );
  }

  void _onTapConfirmButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
          (route) => false,
    );
  }

  @override
  void dispose() {
    //_passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
