import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/global_widgets/custom_button.dart';
import 'package:mathematics_ai/constants/constant_exports.dart';

class ChangeAvatarScreen extends StatefulWidget {
  const ChangeAvatarScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChangeAvatarScreenState();
  }
}

class _ChangeAvatarScreenState extends State<ChangeAvatarScreen> {
  double _avatarSize = 0.5;
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _saveImageToPreferences() async {
    if (_selectedImage != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bytes = await _selectedImage!.readAsBytes();
      final String imgString = base64Encode(bytes);
      await prefs.setString('avatar_image', imgString);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDarkMode ? MathColorTheme().darkScaffold : MathColorTheme().white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
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
                      child: _selectedImage != null
                          ? Image.file(
                        _selectedImage!,
                        width: 162 * _avatarSize,
                        height: 162 * _avatarSize,
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
              const SizedBox(height: 20),
              Text(
                'Change avatar',
                style: MathTextTheme().heading1.copyWith(
                  fontSize: 28,
                  color: isDarkMode ? MathColorTheme().white : MathColorTheme().black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You can add or remove your picture',
                style: MathTextTheme().body.copyWith(
                  color: MathColorTheme().neutral400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),


              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: MathColorTheme().lightIcon, width: 1),
                  ),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _selectedImage != null
                            ? ClipOval(
                          child: Image.file(
                            _selectedImage!,
                            width: 158 * _avatarSize,
                            height: 158 * _avatarSize,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Column(
                          children: [
                            Image.asset(MathAssets.photo, height: 32, width: 32),
                            const SizedBox(height: 8),
                            Text(
                              '+ Add picture',
                              style: MathTextTheme().body.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    MathAssets.photo,
                    height: 18,
                    width: 18,
                    color: isDarkMode ? MathColorTheme().white : MathColorTheme().black,
                  ),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: MathColorTheme().green,
                        inactiveTrackColor: MathColorTheme().neutral200,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 14.0,
                        ),
                        overlayColor: Colors.white.withOpacity(0.3),
                        thumbColor: MathColorTheme().green,
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 24.0,
                        ),
                      ),
                      child: Slider(
                        value: _avatarSize,
                        min: 0.3,
                        max: 1.0,
                        onChanged: (value) {
                          setState(() {
                            _avatarSize = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Image.asset(
                    MathAssets.photo,
                    height: 24,
                    width: 24,
                    color: isDarkMode ? MathColorTheme().white : MathColorTheme().black,
                  ),
                ],
              ),
              const Spacer(),

              Column(
                children: [
                  CustomButton(
                    title: 'Save',
                    onTap: () async {
                      await _saveImageToPreferences();
                      Navigator.pop(context);
                    },
                    buttonColor: MathColorTheme().green,
                  ),
                  const SizedBox(height: 12),
                  CustomButton2(
                    title: 'Delete',
                    onTap: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                    buttonColor: isDarkMode ? MathColorTheme().darkScaffold : MathColorTheme().white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
