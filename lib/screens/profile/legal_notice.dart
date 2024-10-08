import 'dart:typed_data';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constant_exports.dart';
import '../../../providers/theme_provider.dart';

class LegalNoticeScreen extends StatefulWidget {
  const LegalNoticeScreen({super.key});

  @override
  State<LegalNoticeScreen> createState() => _LegalNoticeScreenState();
}

class _LegalNoticeScreenState extends State<LegalNoticeScreen> {
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
                      'Legal Notice',
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
                    '''Contrary to popular belief, Lorem Ipsum is not simply random text. It finds its roots in a work of classical Latin literature dating from 45 BC, making it 2000 years old. A professor at Hampden-Sydney College in Virginia took an interest in one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and while studying all the uses of the word in classical literature, discovered the undisputed source of Lorem Ipsum. \n\nIt actually comes from sections 1.10.32 and 1.10.33 of Cicero's "De Finibus Bonorum et Malorum" (The Supreme Goods and the Supreme Evils). This work, very popular during the Renaissance, is a treatise on the theory of ethics. The first lines of Lorem Ipsum, "Lorem ipsum dolor sit amet...", come from section 1.10.32.''',
                    style: TextStyle(
                      fontSize: 14,
                        height: 1.8,
                      color: Colors.grey.shade600
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