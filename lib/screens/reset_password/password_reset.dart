import 'package:mathematics_ai/screens/reset_password/otp_verification_screen.dart';
import 'package:provider/provider.dart';
import '../../constants/constant_exports.dart';
import '../../providers/theme_provider.dart';
import '../../providers/otp_provider.dart';
import '../../widgets/global_widgets/custom_button.dart';
import '../../widgets/global_widgets/custom_textfield.dart';

class SendResetLinkScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SendResetLinkScreen({super.key});

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
                      'Send OTP',
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
                      "We'll send your OTP to reset your password",
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

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        contentStyle: MathTextTheme().body.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .isDarkMode
                                  ? MathColorTheme().white
                                  : MathColorTheme().lightBlack,
                            ),
                        alignLabelWithText: false,
                        filled: true,
                        fillColor:
                            Provider.of<ThemeProvider>(context, listen: false)
                                    .isDarkMode
                                ? MathColorTheme().darkField
                                : MathColorTheme().lightGray,
                        controller: _emailController,
                        cursorColor: MathColorTheme().green,
                        hintText: '   E-Mail or UserName',
                        hintStyle: MathTextTheme().body.copyWith(
                              fontSize: 14,
                              color: Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .isDarkMode
                                  ? MathColorTheme().brownGray
                                  : MathColorTheme()
                                      .lightBlack
                                      .withOpacity(0.5),
                              fontWeight: FontWeights.medium,
                            ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .isDarkMode
                                  ? MathColorTheme().seaBlue
                                  : MathColorTheme().white,
                              borderRadius: BorderRadius.circular(5.5),
                            ),
                            child: Image.asset(
                              MathAssets.mail,
                              height: 20,
                              width: 20,
                              color: Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .isDarkMode
                                  ? MathColorTheme().white
                                  : MathColorTheme().black,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email or User Name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),
                      Consumer<OTPProvider>(
                        builder: (context, otpProvider, child) {
                          return CustomButton(
                            title: otpProvider.status == OTPStatus.sending
                                ? 'Sending...'
                                : 'Send',
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                final result = await otpProvider.sendOTP(
                                    _emailController.text, true);
                                if (result['status'] == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(otpProvider.message ??
                                            'OTP sent successfully')),
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OtpVerificationScreen(
                                                  identifier:
                                                      _emailController.text)));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(otpProvider.message ??
                                            'Failed to send OTP')),
                                  );
                                }
                              }
                            },
                            buttonColor: MathColorTheme().green,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const SizedBox(height: 16),
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
