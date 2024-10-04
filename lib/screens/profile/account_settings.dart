import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/constant_exports.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/global_widgets/custom_button.dart';
import '../../widgets/global_widgets/custom_textfield.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AccountSettingsScreenState();
  }
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController referralController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isUsernameEditable = false;
  bool isEmailEditable = false;
  bool isPhoneEditable = false;
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
      resizeToAvoidBottomInset: false,
      backgroundColor:
          isDarkMode ? MathColorTheme().darkScaffold : MathColorTheme().white,
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
              const SizedBox(height: 22),
              ListTile(
                tileColor: isDarkMode
                    ? MathColorTheme().darkScaffold
                    : MathColorTheme().white,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    )),
                title: Center(
                  child: Text(
                    'Account Settings',
                    style: MathTextTheme().body.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 28,
                          color: isDarkMode
                              ? MathColorTheme().white
                              : MathColorTheme().black,
                        ),
                  ),
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/avatar');
                    },
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.grey.shade100,
                      child: ClipOval(
                        child: _profileImageBytes != null
                            ? Image.memory(
                                _profileImageBytes!,
                                width: 68,
                                height: 68,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                MathAssets.profile,
                                width: 38,
                                height: 38,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Peter Anderson",
                        style: MathTextTheme().heading1.copyWith(
                              fontSize: 20,
                              color: isDarkMode
                                  ? MathColorTheme().white
                                  : MathColorTheme().black,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Member since 7/1/2023",
                        style: MathTextTheme().body.copyWith(
                              color: isDarkMode
                                  ? MathColorTheme().white
                                  : MathColorTheme().neutral400,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Username',
                style: MathTextTheme().body.copyWith(
                      fontSize: 16,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
              ),
              SizedBoxes.verticalTiny,
              CustomTextField(
                controller: usernameController,
                filled: true,
                readOnly: !isPhoneEditable,
                suffixIcon: IconButton(
                  icon: Image.asset(
                    MathAssets.edit,
                    height: 16,
                    color: isDarkMode
                        ? MathColorTheme().white
                        : MathColorTheme().black,
                  ),
                  onPressed: () {
                    setState(() {
                      isPhoneEditable = !isPhoneEditable;
                    });
                  },
                ),
                fillColor: isDarkMode
                    ? MathColorTheme().darkField
                    : MathColorTheme().lightGray,
              ),
              SizedBoxes.vertical15Px,

              // Email Field
              Text(
                'Referral link',
                style: MathTextTheme().body.copyWith(
                      fontSize: 16,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
              ),
              SizedBoxes.verticalTiny,
              CustomTextField(
                controller: emailController,
                filled: true,
                readOnly: !isEmailEditable,
                suffixIcon: IconButton(
                  icon: Image.asset(MathAssets.copy,
                      height: 17,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black),
                  onPressed: () {
                    setState(() {
                      isEmailEditable = !isEmailEditable;
                    });
                  },
                ),
                fillColor: isDarkMode
                    ? MathColorTheme().darkField
                    : MathColorTheme().lightGray,
              ),
              SizedBoxes.vertical15Px,
              Text(
                'E-Mail',
                style: MathTextTheme().body.copyWith(
                      fontSize: 16,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
              ),
              SizedBoxes.verticalTiny,
              CustomTextField(
                controller: emailController,
                filled: true,
                readOnly: !isPhoneEditable,
                suffixIcon: IconButton(
                  icon: Image.asset(MathAssets.edit,
                      height: 16,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black),
                  onPressed: () {
                    setState(() {
                      isPhoneEditable = !isPhoneEditable;
                    });
                  },
                ),
                fillColor: isDarkMode
                    ? MathColorTheme().darkField
                    : MathColorTheme().lightGray,
              ),
              SizedBoxes.vertical15Px,
              Text(
                'Phone Number',
                style: MathTextTheme().body.copyWith(
                      fontSize: 16,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
              ),
              SizedBoxes.verticalTiny,
              CustomTextField(
                controller: phoneController,
                filled: true,
                readOnly: !isPhoneEditable,
                suffixIcon: IconButton(
                  icon: Image.asset(MathAssets.edit,
                      height: 16,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black),
                  onPressed: () {
                    setState(() {
                      isPhoneEditable = !isPhoneEditable;
                    });
                  },
                ),
                fillColor: isDarkMode
                    ? MathColorTheme().darkField
                    : MathColorTheme().lightGray,
              ),
              const SizedBox(height: 32),

              // Save Button
              CustomButton(
                title: 'Save',
                onTap: () {
                  // Handle save action
                },
                buttonColor: isDarkMode
                    ? MathColorTheme().seaBlue
                    : MathColorTheme().green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
