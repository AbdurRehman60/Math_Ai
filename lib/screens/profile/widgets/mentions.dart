import 'dart:typed_data';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constant_exports.dart';
import '../../../providers/theme_provider.dart';
import '../../../widgets/global_widgets/or_divider.dart';

class Mentions extends StatefulWidget {
  const Mentions({super.key});

  @override
  State<Mentions> createState() => _MentionsState();
}

class _MentionsState extends State<Mentions> {
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
      backgroundColor:
          isDarkMode ? MathColorTheme().darkScaffold : MathColorTheme().white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 10),
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
                    backgroundColor: Provider.of<ThemeProvider>(context,listen: false).isDarkMode ? MathColorTheme().darkField.withOpacity(0.8) : Colors.grey.shade100,
                    child: ClipOval(
                      child: _profileImageBytes != null
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
              SizedBoxes.verticalBig,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Mentions',
                      style: MathTextTheme().body.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 28,
                            color: isDarkMode
                                ? MathColorTheme().white
                                : MathColorTheme().black,
                          ),
                    ),
                  ),
                  SizedBoxes.horizontal2Px,
                ],
              ),
              SizedBoxes.verticalGargangua,
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Legal Notice',
                  style: MathTextTheme().body.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: isDarkMode
                      ? MathColorTheme().white
                      : MathColorTheme().black,
                  size: 16,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/legal');
                },
              ),
              const Dividerr(
                enablePadding: false,
              ),
              _buildSettingsTile(
                  'Terms & Conditions',
                  context,
                  onTap: () {
                Navigator.pushNamed(context, '/terms');
              },
              ),
              const Dividerr(
                enablePadding: false,
              ),
              _buildSettingsTile(
                'Privacy policy',
                context,
                onTap: () {
                  Navigator.pushNamed(context, '/privacyPolicy');
                },
              ),
              const Dividerr(
                enablePadding: false,
              ),
              _buildSettingsTile(
                'Cookie policy',
                context,
                onTap: () {
                  Navigator.pushNamed(context, '/cookiePolicyScreen');
                },
              ),
              const Dividerr(
                enablePadding: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(String title, BuildContext context,
      {required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: MathTextTheme().body.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? MathColorTheme().white
                : MathColorTheme().black),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Provider.of<ThemeProvider>(context).isDarkMode
            ? MathColorTheme().white
            : MathColorTheme().black,
      ),
      onTap: onTap,
    );
  }
}
