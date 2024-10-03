import 'package:mathematics_ai/providers/theme_provider.dart';
import 'package:mathematics_ai/screens/login/login_form.dart';
import 'package:provider/provider.dart';
import '../../constants/constant_exports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                Image.asset(
                  MathAssets.logo,
                  height: 44,
                  width: 44,
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: MathTextTheme().body.copyWith(
                          fontSize: 37,
                          fontWeight: FontWeight.w500,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Start learning math with love and without fear.',
                        style: MathTextTheme().subtext.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeights.light,
                            color: Provider.of<ThemeProvider>(context,listen: false).isDarkMode ? MathColorTheme().brownGray : MathColorTheme().lightBlack),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const LoginForm(),
                const Spacer(),
                Text(
                  "© Bienvenue 2024 All rights reserved",
                  style: MathTextTheme().subtext.copyWith(
                        color: MathColorTheme().neutral400,
                      ),
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
