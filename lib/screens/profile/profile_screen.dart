import 'package:mathematics_ai/screens/login/login_screen.dart';
import 'package:mathematics_ai/widgets/global_widgets/or_divider.dart';
import 'package:provider/provider.dart';
import 'package:mathematics_ai/constants/constant_exports.dart';
import '../../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    MathAssets.logo,
                    height: 40,
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade100,
                    child: ClipOval(
                      child: Image.asset(
                        MathAssets.profile,
                        width: 28,
                        height: 28,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBoxes.vertical26Px,
              Text(
                'Settings',
                style: MathTextTheme()
                    .body
                    .copyWith(fontSize: 32, fontWeight: FontWeight.w500),
              ),
              SizedBoxes.vertical25Px,
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Account',
                  style: MathTextTheme()
                      .body
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 16,),
                onTap: () {
                  Navigator.pushNamed(context, '/accountSettings');
                },
              ),
              const Dividerr(
                enablePadding: false,
              ),

              _buildSettingsTile('Privacy settings', onTap: () {

              }),
              const Dividerr(
                enablePadding: false,
              ),
              _buildSettingsTile('Appearance', onTap: () {
              }),
              const Dividerr(
                enablePadding: false,
              ),
              _buildSettingsTile('Mentions', onTap: () {

              }),
              const Dividerr(
                enablePadding: false,
              ),
              _buildDarkModeTile(
                  themeProvider, isDarkMode),
              const Spacer(),
              const Dividerr(
                enablePadding: false,
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(bottom: 20),
                title: Text(
                  'Logout',
                  style: MathTextTheme().body.copyWith(
                        color: MathColorTheme().errorRed,
                      ),
                ),
                trailing: Icon(Icons.arrow_forward_ios,
                    size: 16, color: MathColorTheme().errorRed),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(String title, {required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: MathTextTheme()
            .body
            .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildDarkModeTile(ThemeProvider themeProvider, bool isDarkMode) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        'Dark Mode',
        style: MathTextTheme().body,
      ),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) {
          themeProvider
              .toggleTheme(value);
        },
        activeColor: MathColorTheme().green,
      ),
    );
  }
}
