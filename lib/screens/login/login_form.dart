import 'package:mathematics_ai/providers/theme_provider.dart';
import 'package:mathematics_ai/widgets/bottom_navigation_bar/navigation_bar.dart';
import 'package:provider/provider.dart';
import '../../constants/constant_exports.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/global_widgets/custom_button.dart';
import '../../widgets/global_widgets/custom_textfield.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final auth = Provider.of<AuthProvider>(context);

    void onLoginPressed() async {
      if (formKey.currentState!.validate()) {
        // Start authentication process
        auth.status = AuthStatus.authenticating;

        try {
          // Perform login and await response
          final response = await auth.login(
            emailController.text,
            passwordController.text,
          );

          print('Login response: $response');

          // Handle the response based on success status
          if (response['status']) {
            print('Login successful');

            // Navigate to the main page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
            );
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text(response['message'] ?? 'Login successful')));
          } else {
            print('Login failed: ${response['message']}');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  response['message'] ?? 'Login failed',
                  style: MathTextTheme().body.copyWith(fontSize: 14,color: Colors.white),
                )));
          }
        } catch (e) {
          // Handle any unexpected errors
          print('Error during login: $e');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'An error occurred: $e',
                style: MathTextTheme().body.copyWith(fontSize: 14,color: Colors.white),
              )));
        } finally {
          auth.status = AuthStatus.notLoggedIn;
        }
      }
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            contentStyle: MathTextTheme().body.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                  ? MathColorTheme().white
                  : MathColorTheme().lightBlack,
            ),
            alignLabelWithText: false,
            filled: true,
            fillColor: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                ? MathColorTheme().darkField
                : MathColorTheme().lightGray,
            controller: emailController,
            cursorColor: MathColorTheme().green,
            hintText: '   User Name',
            hintStyle: MathTextTheme().body.copyWith(
              fontSize: 14,
              color: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                  ? MathColorTheme().brownGray
                  : MathColorTheme().lightBlack.withOpacity(0.5),
              fontWeight: FontWeights.medium,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context,listen: false).isDarkMode ? MathColorTheme().seaBlue :  MathColorTheme().white,
                  borderRadius: BorderRadius.circular(5.5),
                ),
                child: Image.asset(
                  MathAssets.profile,
                  height: 20,
                  width: 20,
                  color: Provider.of<ThemeProvider>(context,listen: false).isDarkMode ? MathColorTheme().white :  MathColorTheme().black,
                ),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your user name';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),
          CustomTextField(
            contentStyle: MathTextTheme().body.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                  ? MathColorTheme().white
                  : MathColorTheme().lightBlack,
            ),
            alignLabelWithText: false,
            filled: true,
            fillColor: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                ? MathColorTheme().darkField
                : MathColorTheme().lightGray,
            controller: passwordController,
            obscureText: true,
            cursorColor: MathColorTheme().green,
            hintText: '   Password',
            hintStyle: MathTextTheme().body.copyWith(
              fontSize: 14,
              color: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                  ? MathColorTheme().brownGray
                  : MathColorTheme().lightBlack.withOpacity(0.5),
              fontWeight: FontWeights.medium,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context,listen: false).isDarkMode ? MathColorTheme().seaBlue :  MathColorTheme().white,
                  borderRadius: BorderRadius.circular(5.5),
                ),
                child: Image.asset(
                  MathAssets.lock,
                  height: 20,
                  width: 20,
                  color: Provider.of<ThemeProvider>(context,listen: false).isDarkMode ? MathColorTheme().white :  MathColorTheme().black,
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

          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reset');
              },
              child: Text(
                'Forgot password?',
                style: MathTextTheme().body.copyWith(
                  color: MathColorTheme().green,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          auth.status == AuthStatus.authenticating
              ?  CircularProgressIndicator(color: MathColorTheme().green,)
              : CustomButton(
            title: 'Login',
            onTap: onLoginPressed,
          ),
        ],
      ),
    );
  }
}

