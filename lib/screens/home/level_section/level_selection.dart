import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constant_exports.dart';
import '../../../providers/theme_provider.dart';
import '../widgets/exercise_card.dart';

class LevelSection extends StatefulWidget {
  const LevelSection({super.key});

  @override
  State<LevelSection> createState() => _LevelSectionState();
}

class _LevelSectionState extends State<LevelSection> {
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
              ),
              SizedBoxes.verticalBig,
              const ExerciseCard(
                color: Color(0xFFBFF7FF),
                title: 'Sixth',
                exercises: 16,
              ),
              SizedBoxes.verticalBig,
              const ExerciseCard(
                color: Color(0xFFE8C1FF),
                title: 'Fifth',
                exercises: 15,
              ),
              SizedBoxes.verticalBig,
              const ExerciseCard(
                color: Color(0xFFFFD3B4),
                title: 'Fourth',
                exercises: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
