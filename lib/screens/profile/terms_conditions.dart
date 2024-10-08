import 'dart:typed_data';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constant_exports.dart';
import '../../../providers/theme_provider.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
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
                    backgroundColor: Colors.grey.shade100,
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
                      'Terms & Conditions',
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
                '''Several variations of Lorem Ipsum can be found here and there, but the majority have suffered alteration by adding humor or randomized words which don't look alike for a second like standard text. If you are going to use a passage of Lorem Ipsum, you need to be sure there is nothing embarrassing hidden in the text. All Lorem Ipsum generators on the Internet tend to reproduce the same snippet over and over, making lipsum.com the only true Lorem Ipsum generator.\n\nIt uses a dictionary of more than 200 Latin words, in combination of several sentence structures, to generate impeccable Lorem Ipsum. The resulting Lorem Ipsum contains no repetition, crazy words, or touches of humor.''',
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