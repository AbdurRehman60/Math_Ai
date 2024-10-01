import 'package:mathematics_ai/constants/constant_exports.dart';
import 'package:mathematics_ai/screens/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MathTheme _theme = MathTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _theme.data,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),);
  }
}
