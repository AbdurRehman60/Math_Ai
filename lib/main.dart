import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mathematics_ai/constants/constant_exports.dart';
import 'package:mathematics_ai/providers/auth_provider.dart';
import 'package:mathematics_ai/providers/theme_provider.dart';
import 'package:mathematics_ai/screens/home/course_exercise_screen.dart';
import 'package:mathematics_ai/screens/home/home_screen.dart';
import 'package:mathematics_ai/screens/home/level_section/level_selection.dart';
import 'package:mathematics_ai/screens/login/login_screen.dart';
import 'package:mathematics_ai/screens/profile/account_settings.dart';
import 'package:mathematics_ai/screens/profile/appearance_screen.dart';
import 'package:mathematics_ai/screens/profile/change_avatar.dart';
import 'package:mathematics_ai/screens/profile/cookie_policy.dart';
import 'package:mathematics_ai/screens/profile/legal_notice.dart';
import 'package:mathematics_ai/screens/profile/privacy_policy.dart';
import 'package:mathematics_ai/screens/profile/terms_conditions.dart';
import 'package:mathematics_ai/screens/profile/widgets/mentions.dart';
import 'package:mathematics_ai/screens/profile/widgets/privacy_settings.dart';
import 'package:mathematics_ai/screens/reset_password/reset.dart';
import 'package:mathematics_ai/widgets/bottom_navigation_bar/navigation_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MathTheme _theme = MathTheme();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context)=> ThemeProvider())

      ],
      child: MaterialApp(
        routes: {
          'login': (context) => const LoginScreen(),
          '/reset': (context) =>  NewPasswordScreen(),
          '/accountSettings': (context) => const AccountSettingsScreen(),
          '/avatar' : (context) => const ChangeAvatarScreen(),
          '/privacySettings' : (context) => const PrivacySettings(),
          '/mentions': (context) => const Mentions(),
          '/appearance' : (context) => const AppearanceScreen(),
          '/home' : (context) => const HomeScreen(),
          '/level' : (context) => const LevelSection(),
          '/legal': (context) => const LegalNoticeScreen(),
          '/terms' : (context) => const TermsConditionsScreen(),
          '/privacyPolicy': (context) => const PrivacyPolicyScreen(),
          '/cookiePolicyScreen': (context)=> const CookiePolicyScreen(),
          '/course' : (context) => const CourseScreen(),
        },
        theme: _theme.data,
        debugShowCheckedModeBanner: false,
        home: _AppStartScreen(),
      ),
    );
  }
}

class _AppStartScreen extends StatelessWidget {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> _hasValidToken() async {
    final token = await _storage.read(key: 'access_token');
    print('tokenStatus :$token');
    return token != null;

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasValidToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.data == true) {
          return const BottomNavBar();
        } else {
          return  const LoginScreen();
        }
      },
    );
  }
}
