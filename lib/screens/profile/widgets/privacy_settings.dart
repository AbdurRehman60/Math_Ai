import 'dart:typed_data';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/constant_exports.dart';
import '../../../providers/theme_provider.dart';
import '../../../widgets/global_widgets/custom_button.dart';
import '../../../widgets/global_widgets/custom_textfield.dart';

class PrivacySettings extends StatefulWidget {
  const PrivacySettings({super.key});

  @override
  State<PrivacySettings> createState() => _PrivacySettingsState();
}

class _PrivacySettingsState extends State<PrivacySettings> {
  final TextEditingController currentPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  bool isCurrentPassEditable = false;
  bool newPassEditable = false;
  bool confirmPassEditable = false;
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
                      'Password',
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
              Text(
                'Currently password',
                style: MathTextTheme().body.copyWith(
                      fontSize: 16,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
              ),
              SizedBoxes.vertical10Px,
              CustomTextField(
                controller: currentPassController,
                filled: true,
                fillColor: isDarkMode
                    ? MathColorTheme().darkField
                    : MathColorTheme().lightGray,
                readOnly: !isCurrentPassEditable,
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
                      isCurrentPassEditable = !isCurrentPassEditable;
                    });
                  },
                ),
                hintText: 'Enter current password',
              ),
              SizedBoxes.verticalBig,
              Text(
                'New password',
                style: MathTextTheme().body.copyWith(
                      fontSize: 16,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
              ),
              SizedBoxes.vertical10Px,
              CustomTextField(
                controller: newPassController,
                filled: true,
                fillColor: isDarkMode
                    ? MathColorTheme().darkField
                    : MathColorTheme().lightGray,
                readOnly: !newPassEditable,
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
                      newPassEditable = !newPassEditable;
                    });
                  },
                ),
                hintText: 'Enter new password',
              ),
              SizedBoxes.verticalBig,
              Text(
                'Confirm new password',
                style: MathTextTheme().body.copyWith(
                      fontSize: 16,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
              ),
              SizedBoxes.vertical10Px,
              CustomTextField(
                controller: confirmPassController,
                filled: true,
                fillColor: isDarkMode
                    ? MathColorTheme().darkField
                    : MathColorTheme().lightGray,
                readOnly: !confirmPassEditable,
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
                      confirmPassEditable = !confirmPassEditable;
                    });
                  },
                ),
                hintText: 'Confirm new password',
              ),
              SizedBoxes.verticalGargangua,
              CustomButton(
                buttonColor: isDarkMode
                    ? MathColorTheme().midBlue
                    : MathColorTheme().lightGray.withOpacity(0.7),
                onTap: () {},
                title: 'Save',
              ),
              SizedBoxes.verticalGargangua,
              Text(
                'Delete account',
                style: MathTextTheme().body.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
              ),
              SizedBoxes.vertical10Px,
              Text(
                'Would you like to delete your account? Deleting your account will remove all the content associated with it',
                style: MathTextTheme().body.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
              ),
              SizedBoxes.vertical15Px,
              InkWell(
                onTap: () {
                  showDeleteConfirmationBottomSheet(context);
                },
                child: Text(
                  'I want to delete my account',
                  style: MathTextTheme().body.copyWith(
                      fontSize: 14,
                      color: MathColorTheme().errorRed,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: MathColorTheme().errorRed),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteConfirmationBottomSheet(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final bool isDarkMode = themeProvider.isDarkMode;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: isDarkMode
                ? MathColorTheme().darkScaffold
                : MathColorTheme().white,
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                MathAssets.warning,
                height: 64,
                width: 64,
              ),
              SizedBoxes.verticalBig,
              Text(
                'Account Delete',
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
                'Are you sure you want to delete your account?',
                style: MathTextTheme().body.copyWith(
                      fontSize: 16,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBoxes.verticalGargangua,
              CustomButton(
                title: 'No',
                onTap: () {
                  Navigator.pop(context);
                },
                buttonColor: MathColorTheme().green,
              ),
              SizedBoxes.vertical15Px,
              CustomButton2(
                title: 'Yes',
                onTap: () {
                  Navigator.pop(context);
                },
                buttonColor: isDarkMode
                    ? MathColorTheme().darkScaffold
                    : MathColorTheme().white,
              ),
            ],
          ),
        );
      },
    );
  }
}
