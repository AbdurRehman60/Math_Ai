import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/constant_exports.dart';
import '../../../providers/theme_provider.dart';
import '../../reset_password/menu_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MenuProvider>(context, listen: false).fetchMenus();
    });
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
                      backgroundColor: isDarkMode
                          ? MathColorTheme().darkField.withOpacity(0.8)
                          : Colors.grey.shade100,
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
              Consumer<MenuProvider>(
                builder: (context, menuProvider, child) {
                  if (menuProvider.state == MenuState.loading) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: MathColorTheme().green,
                      ),
                    );
                  } else if (menuProvider.state == MenuState.loaded) {
                    return Column(
                      children: menuProvider.menus.map((menu) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ExerciseCard(
                            color: _getExerciseCardColor(menu.order),
                            title: menu.title,
                            exercises: menu.subUnits,
                            submenus: menu.submenus,
                            order: menu.order,
                          ),
                        );
                      }).toList(),
                    );
                  } else if (menuProvider.state == MenuState.error) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text('Error: ${menuProvider.errorMessage}'),
                      ),
                    );
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      alignment: Alignment.center,
                      child: const Text('No data available'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getExerciseCardColor(int order) {
    switch (order) {
      case 1:
        return const Color(0xFFBFF7FF);
      case 2:
        return const Color(0xFFE8C1FF);
      case 3:
        return const Color(0xFFFFD3B4);
      case 4:
        return const Color(0xFFFFB0C3);
      case 5:
        return const Color(0xFF8AF6DC);
      case 6:
        return const Color(0xFFFFE589);
      case 7:
        return const Color(0xFFD5EE8C);
      case 8:
        return const Color(0xFFB8C7FA);
      case 9:
        return const Color(0xFFFF9A7A);
      case 10:
        return const Color(0xFFE0A6A8);
      default:
        return const Color(0xFFBFF7FF);
    }
  }
}
