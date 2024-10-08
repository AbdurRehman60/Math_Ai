import 'dart:typed_data';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constant_exports.dart';
import '../../../providers/theme_provider.dart';

class CookiePolicyScreen extends StatefulWidget {
  const CookiePolicyScreen({super.key});

  @override
  State<CookiePolicyScreen> createState() => _CookiePolicyScreenState();
}

class _CookiePolicyScreenState extends State<CookiePolicyScreen> {
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
                      'Cookie Policy',
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
                    '''Lorem Ipsum is simply dummy text used in typesetting and printing. Lorem Ipsum has been the standard dummy text of printing ever since the 1500s, when an anonymous printer scrambled scraps of text to make a type specimen book.\n\nIt has not only survived five centuries, but has also adapted to computer office automation, without its content being modified. It was popularized in the 1960s with the sale of Letraset sheets containing Lorem Ipsum passages, and more recently with its inclusion in text layout applications, such as Aldus PageMaker.''',
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