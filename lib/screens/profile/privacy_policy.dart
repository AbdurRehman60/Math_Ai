import 'dart:typed_data';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constant_exports.dart';
import '../../../providers/theme_provider.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
          padding: const EdgeInsets.all(16.0),
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
              Center(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color:
                          Provider.of<ThemeProvider>(context).isDarkMode
                              ? MathColorTheme().white
                              : MathColorTheme().black,
                        )),
                    SizedBoxes.horizontal26Px,
                    Text(
                      'Privacy Policy',
                      style: MathTextTheme().heading1.copyWith(
                        fontSize: 24,
                        color: isDarkMode
                            ? MathColorTheme().white
                            : MathColorTheme().black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                '''It has long been known that working with readable, meaningful text is distracting and prevents you from concentrating on the layout itself. The advantage of Lorem Ipsum over generic text like 'Some text. Of text. Of text.' is that it has a more or less normal distribution of letters, and in any case comparable with that of standard French.\n\nMany layout software suites or website editors have made Lorem Ipsum their default dummy text, and a search for 'Lorem Ipsum' will take you to many sites which are still in their development phase. construction. Several versions have appeared over time, sometimes by accident, often intentionally (just to add little winks, or even embarrassing sentences).''',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.8,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),

            ],
          ),
        ),
      ),
    );
  }
}