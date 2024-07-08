import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/auth/reset_password_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();
  bool _loadingInProgress = false;

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
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digit verification pin has been sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),

                  _buildPinCodeTextField(), //Don't need context because of it's a stateful widget

                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onTapVerifyOtpButton,
                    child: const Text('Verify'),
                  ),

                  const SizedBox(height: 36),

                  _buildSignInSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInSection() {
    return Center(
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
                      ..onTap = _onTapSignInButton),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      // obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        selectedFillColor: Colors.white,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedColor: AppColors.themeColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      keyboardType: TextInputType.number,
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      // errorAnimationController: errorController,
      controller: _pinTEController,
      appContext: context,
      autoDisposeControllers: false,
    );
  }

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
      (route) => false,
    );
  }

  /**/

  void _otpVerification() async {
    _loadingInProgress = true;

    String otp = _pinTEController.text.trim();

    loadingDialog(context);

    String url = "${Urls.recoverVerifyOTP}/${widget.email}/$otp";
    NetworkResponse response = await NetworkCaller.getResponse(url);

    _loadingInProgress = false;

    if (mounted) {
      Navigator.pop(context);
    }

    if (response.responseData['status'] == 'success') {
      _clearOtpField();
      if (mounted) {
        _onTapVerifyOtpButton.onTap(
          context,
          widget.email,
          otp,
        );
      }
    } else if (response.responseData['status'] == 'fail') {
      _clearOtpField();
      if (mounted) {
        oneButtonDialog(
          context,
          AppColors.themeColor,
          "Failed!",
          "Please enter valid otp!",
          Icons.error_outline_rounded,
              () {
            Navigator.pop(context);
          },
        );
      }
    } else {
      _clearOtpField();

      if (mounted) {
        oneButtonDialog(
          context,

          AppColors.themeColor,
          "Failed!",
          "Something went wrong!",
          Icons.error_outline_rounded,
              () {
            Navigator.pop(context);
          },
        );
      }
    }
  }

  void _resendOtp() async {
    _loadingInProgress = true;

    loadingDialog(context);

    NetworkResponse response = await NetworkCaller.getResponse(
      "${ApiUrl.recoverVerifyEmail}/${widget.email}",
    );

    _loadingInProgress = false;

    if (mounted) {
      Navigator.pop(context);
    }

    if (response.responseData['status'] == 'success') {
      if (mounted) {
        _onTapVerifyOtpButton(
          context,
          AppColors.themeColor,
          AppColors.themeColor,
          "Resend success!",
          "Please check your email and collect otp.",
          Icons.task_alt,
              () {
            Navigator.pop(context);
          },
        );
      }
    }else {
      if (mounted) {
        oneButtonDialog(
          context,
          AppColors.white,
          AppColors.themeColor,
          "Failed!",
          "Otp send failed, Resend again!",
          Icons.task_alt,
              () {
            Navigator.pop(context);
          },
        );
      }
    }
  }

  void _onTapVerifyOtpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _pinTEController.dispose();
    super.dispose();
  }
}
