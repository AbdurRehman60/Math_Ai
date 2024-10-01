import '../../constants/constant_exports.dart';
import '../../widgets/global_widgets/custom_button.dart';
import '../../widgets/global_widgets/custom_textfield.dart';
import '../../widgets/global_widgets/or_divider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height, // Set the height to the full screen
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80), // Space from top

                // Logo
                Image.asset(
                  MathAssets.logo, // Your logo asset here
                  height: 44,
                  width: 44,
                ),

                const SizedBox(height: 20),

                // Welcome Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: MathTextTheme()
                          .body
                          .copyWith(fontSize: 37, fontWeight: FontWeights.medium),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Start learning math with a love and without fear.',
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
                      CustomTextField(
                        filled: true,
                        fillColor: MathColorTheme().lightGray,
                        controller: _emailController,
                        cursorColor: MathColorTheme().green,
                        hintText: 'Email',
                        hintStyle: MathTextTheme().body.copyWith(
                            fontSize: 14,
                            color: MathColorTheme()
                                .lightBlack
                                .withOpacity(0.5),
                            fontWeight: FontWeights.medium),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.5),
                              border: Border.all(
                                color: MathColorTheme().lightGray,
                              ),
                            ),
                            child: Image.asset(
                              MathAssets.profile,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      CustomTextField(
                        filled: true,
                        fillColor: MathColorTheme().lightGray,
                        controller: _passwordController,
                        obscureText: true,
                        hintStyle: MathTextTheme().body.copyWith(
                            fontSize: 14,
                            color: MathColorTheme()
                                .lightBlack
                                .withOpacity(0.5),
                            fontWeight: FontWeights.medium),
                        hintText: 'Password',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.5),
                              border: Border.all(
                                color: MathColorTheme().lightGray,
                              ),
                            ),
                            child: Image.asset(
                              MathAssets.lock,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                          },
                          child: const Icon(Icons.visibility),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                          },
                          child: Text(
                            'Forgot password?',
                            style: MathTextTheme().body.copyWith(
                              color: MathColorTheme().green,
                              fontWeight: FontWeight.w500,
                              fontSize: 14
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Login Button
                      CustomButton(
                        title: 'Login',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {

                          }
                        },
                      ),
                      SizedBoxes.verticalGargangua,
                      const OrDivider(),
                      SizedBoxes.verticalGargangua,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Google Button
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: MathColorTheme().white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: MathColorTheme().gray,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                onPressed: () {

                                },
                                icon: Image.asset(
                                    MathAssets.google, height: 24),
                                label: Text(
                                  'Google',
                                  style: MathTextTheme().body.copyWith(
                                      color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Facebook Button
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: MathColorTheme().white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: MathColorTheme().gray,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                onPressed: () {

                                },
                                icon: Image.asset(
                                    MathAssets.facebook, height: 24), // Facebook logo
                                label: Text(
                                  'Facebook',
                                  style: MathTextTheme().body.copyWith(
                                      color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBoxes.verticalGargangua,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: MathTextTheme().subtext.copyWith(color: MathColorTheme().neutral400,fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: MathColorTheme().green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // Footer
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
