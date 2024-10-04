import 'package:provider/provider.dart';

import '../../constants/constant_exports.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/global_widgets/custom_button.dart';
import '../../widgets/global_widgets/custom_textfield.dart';

class NewPasswordScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  NewPasswordScreen({super.key});

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
                  MathAssets.logo,
                  height: 44,
                  width: 44,
                ),

                const SizedBox(height: 20),

                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'New Password',
                      style: MathTextTheme().body.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeights.medium,
                          color:
                              Provider.of<ThemeProvider>(context, listen: false)
                                      .isDarkMode
                                  ? MathColorTheme().white
                                  : MathColorTheme().black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Subtitle
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Make a new password!',
                      style: MathTextTheme().subtext.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeights.light,
                          color: MathColorTheme().lightBlack),
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
                      // Password TextField
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
                        controller: _passwordController,
                        obscureText: true,
                        cursorColor: MathColorTheme().green,
                        hintText: '   New Password',
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
                          padding: const EdgeInsets.all(3.0),
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
                              MathAssets.lock,
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
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

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
                        controller: _confirmPasswordController,
                        obscureText: true,
                        cursorColor: MathColorTheme().green,
                        hintText: '  Confirm Password',
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
                          padding: const EdgeInsets.all(3.0),
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
                              MathAssets.lock,
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
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),
                      CustomButton(
                        title: 'Reset password',
                        onTap: () {
                          _showSuccessModal(context);
                          if (_formKey.currentState!.validate()) {}
                        },
                        buttonColor: MathColorTheme().green,
                      ),
                    ],
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

  void _showSuccessModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.44,
          maxChildSize: 0.5,
          minChildSize: 0.3,
          builder: (BuildContext context, ScrollController scrollController) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Provider.of<ThemeProvider>(context, listen: false)
                            .isDarkMode
                        ? MathColorTheme().darkScaffold
                        : MathColorTheme().white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Notch
                      Container(
                        width: 80,
                        height: 2,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Image.asset(
                        MathAssets.unlock,
                        height: 64,
                      ),
                      SizedBoxes.vertical15Px,
                      Text(
                        'Password successfully\n changed',
                        style: MathTextTheme().body.copyWith(
                          color:   Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                                ? MathColorTheme().white
                                : MathColorTheme().black,
                            fontSize: 20, fontWeight: FontWeights.medium),
                        textAlign: TextAlign.center,
                      ),
                      SizedBoxes.verticalTiny,
                      Text(
                        'Congratulations, your password was\n successfully changed',
                        style: MathTextTheme().subtext.copyWith(
                          color: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                              ? MathColorTheme().neutral400
                              : MathColorTheme().black,
                            fontSize: 14, fontWeight: FontWeights.light),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        title: 'Go to Log In page',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        buttonColor: MathColorTheme().black,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 18,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Provider.of<ThemeProvider>(context,listen: false).isDarkMode ? MathColorTheme().seaBlue : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child:  Icon(
                        Icons.close,
                        color: Provider.of<ThemeProvider>(context,listen: false).isDarkMode ? MathColorTheme().white : Colors.black,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
