import 'dart:typed_data';

import 'package:mathematics_ai/screens/login/login_screen.dart';
import 'package:mathematics_ai/widgets/global_widgets/or_divider.dart';
import 'package:provider/provider.dart';
import 'package:mathematics_ai/constants/constant_exports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/global_widgets/custom_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Uint8List? _profileImageBytes;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imgString = prefs.getString('avatar_image');

    if (imgString != null) {
      setState(() {
        _profileImageBytes = base64Decode(imgString);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode ? MathColorTheme().darkScaffold : Colors.white,
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
                    isDarkMode ? MathAssets.darkLogo : MathAssets.logo,
                    height: 40,
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade100,
                    child: ClipOval(
                      child:  _profileImageBytes != null
                          ? Image.memory(
                        _profileImageBytes!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
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
                    .copyWith(
                    color: isDarkMode ? MathColorTheme().white : MathColorTheme().black,
                fontSize: 32, fontWeight: FontWeight.w500),
              ),
              SizedBoxes.vertical25Px,
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Account',
                  style: MathTextTheme()
                      .body
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w700,color: isDarkMode ? MathColorTheme().white : MathColorTheme().black),
                ),
                trailing:  Icon(
                  Icons.arrow_forward_ios,
                    color: isDarkMode ? MathColorTheme().white : MathColorTheme().black,
                    size: 16,),
                onTap: () {
                  Navigator.pushNamed(context, '/accountSettings');
                },
              ),
              const Dividerr(
                enablePadding: false,
              ),

              _buildSettingsTile('Privacy settings',context, onTap: () {
                Navigator.pushNamed(context, '/privacySettings');
              }),
              const Dividerr(
                enablePadding: false,
              ),
              _buildSettingsTile('Appearance', context,onTap: () {
              }),
              const Dividerr(
                enablePadding: false,
              ),
              _buildSettingsTile('Mentions', context,onTap: () {
                Navigator.of(context).pushNamed('/mentions');

              }),
              const Dividerr(
                enablePadding: false,
              ),
              _buildDarkModeTile(
                  themeProvider, isDarkMode,context),
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
                  showLogoutConfirmationBottomSheet(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutConfirmationBottomSheet(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final bool isDarkMode = themeProvider.isDarkMode;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12)
            ),
            color: isDarkMode
                ? MathColorTheme().darkScaffold
                : MathColorTheme().white,
          ),

          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                MathAssets.logout,
                height: 64,
                width: 64,
              ),
              SizedBoxes.verticalBig,
              Text(
                'Wanna leave?',
                style: MathTextTheme().body.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? MathColorTheme().white
                      : MathColorTheme().black,
                ),
              ),
              SizedBoxes.vertical10Px,
              Text(
                'Are you sure you want to log out?',
                style: MathTextTheme().body.copyWith(
                  fontSize: 16,
                  color: isDarkMode
                      ? MathColorTheme().white
                      : MathColorTheme().black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBoxes.verticalGargangua,
              CustomButton2(
                title: 'Yes',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                },
                buttonColor: isDarkMode
                    ? MathColorTheme().darkScaffold
                    : MathColorTheme().white,
              ),
              SizedBoxes.vertical15Px,
              CustomButton(
                title: 'No',
                onTap: () {
                  Navigator.pop(context);
                },
                buttonColor: MathColorTheme().green,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSettingsTile(String title,BuildContext context, {required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: MathTextTheme()
            .body
            .copyWith(fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Provider.of<ThemeProvider>(context).isDarkMode ? MathColorTheme().white : MathColorTheme().black),
      ),
      trailing:  Icon(Icons.arrow_forward_ios, size: 16,
      color: Provider.of<ThemeProvider>(context).isDarkMode ? MathColorTheme().white : MathColorTheme().black,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDarkModeTile(ThemeProvider themeProvider, bool isDarkMode,BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        'Dark Mode',
        style: MathTextTheme().body.copyWith(
          color: Provider.of<ThemeProvider>(context).isDarkMode ? MathColorTheme().white : MathColorTheme().black
        ),
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
