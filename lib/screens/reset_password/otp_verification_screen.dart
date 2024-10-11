import 'package:mathematics_ai/screens/reset_password/new_password.dart';
import 'package:provider/provider.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../constants/constant_exports.dart';
import '../../providers/otp_verification_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/global_widgets/custom_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.identifier});
  final String identifier;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _otpCode;

  Future<void> _verifyOTP(BuildContext context) async {
    if (_otpCode != null && _otpCode!.length == 4) {
      final verifyOTPProvider =
          Provider.of<VerifyOTPProvider>(context, listen: false);
      final result =
          await verifyOTPProvider.verifyOTP(_otpCode!, widget.identifier, true);

      if (result['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP Verified Successfully')),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewPasswordScreen(
              otp: _otpCode!,
              email: widget.identifier,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(verifyOTPProvider.message ?? 'Verification failed')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeProvider>(context, listen: false).isDarkMode
              ? MathColorTheme().darkScaffold
              : MathColorTheme().white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),

                // Logo
                Image.asset(
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                      ? MathAssets.greenLogo
                      : MathAssets.logo,
                  height: 44,
                  width: 44,
                ),

                const SizedBox(height: 20),

                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Verify OTP',
                      style: MathTextTheme().body.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeights.medium,
                          color:
                              Provider.of<ThemeProvider>(context, listen: false)
                                      .isDarkMode
                                  ? MathColorTheme().white
                                  : MathColorTheme().black),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Please enter the OTP sent to your email",
                      style: MathTextTheme().subtext.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeights.light,
                          color:
                              Provider.of<ThemeProvider>(context, listen: false)
                                      .isDarkMode
                                  ? MathColorTheme().white
                                  : MathColorTheme().black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // OTP TextField
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      OtpTextField(
                        numberOfFields: 4,
                        borderColor:
                            Provider.of<ThemeProvider>(context, listen: false)
                                    .isDarkMode
                                ? MathColorTheme().green
                                : MathColorTheme().lightBlack,
                        focusedBorderColor: MathColorTheme().green,
                        showFieldAsBox: true,
                        filled: true,
                        fillColor:
                            Provider.of<ThemeProvider>(context, listen: false)
                                    .isDarkMode
                                ? MathColorTheme().darkField
                                : MathColorTheme().lightGray,
                        textStyle: MathTextTheme().body.copyWith(
                              fontSize: 20,
                              color: Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .isDarkMode
                                  ? MathColorTheme().white
                                  : MathColorTheme().black,
                            ),
                        onCodeChanged: (String code) {
                          setState(() {
                            _otpCode = code;
                          });
                        },
                        onSubmit: (String otp) async {
                          setState(() {
                            _otpCode = otp;
                          });
                          await _verifyOTP(
                              context);
                        },
                      ),
                      const SizedBox(height: 24),
                      Consumer<VerifyOTPProvider>(
                        builder: (context, verifyOTPProvider, child) {
                          return CustomButton(
                            title: verifyOTPProvider.status ==
                                    OTPVerifyStatus.verifying
                                ? 'Verifying...'
                                : 'Verify OTP',
                            onTap: () async {
                              await _verifyOTP(
                                  context);
                            },
                            buttonColor: MathColorTheme().green,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back to Log In',
                    style: MathTextTheme().subtext.copyWith(
                          color: MathColorTheme().green,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),

                const Spacer(),
                Text(
                  "© Bienvenue 2024 All rights reserved",
                  style: MathTextTheme()
                      .subtext
                      .copyWith(color: MathColorTheme().neutral400),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
