import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/auth/pin_verification_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import '../../../data/models/network_response.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
import '../../widgets/snack_bar_message.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  bool _emailVerificationInProgress = false;

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
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digit verification pin will sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  // const SizedBox(height: 8),
                  // TextFormField(
                  //   controller: _passwordTEController,
                  //   decoration: InputDecoration(
                  //     hintText: 'Password',
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: _emailVerificationInProgress == false,
                    replacement: const CenteredProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapConfirmButton,
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Center(
                    child: Column(
                      children: [
                        // TextButton(
                        //   onPressed: () {},
                        //   child: const Text('Forgot Password?'),
                        // ),
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
                                    ..onTap = _onTapSignInButton),
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
    Navigator.pop(context);
  }

  void _onTapConfirmButton() {
    _verifyEmail(_emailTEController.text.trim());
  }

  Future<void> _verifyEmail(String email) async {
    _emailVerificationInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.verifyEmail(email));
    _emailVerificationInProgress = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess && response.responseData['status'] == 'success') {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PinVerificationScreen(email: email),
          ),
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Email verification failed! Try again.');
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    //_passwordTEController.dispose();
    super.dispose();
  }
}
