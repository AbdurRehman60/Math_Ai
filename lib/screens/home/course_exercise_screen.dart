import 'dart:typed_data';
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';
import '../../constants/constant_exports.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  Uint8List? _profileImageBytes;

  @override
  void initState() {
    super.initState();
    // Load Profile Image or any other init logic
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;
    final Color scaffoldColor =
        isDarkMode ? MathColorTheme().darkScaffold : MathColorTheme().white;

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with Logo and Profile Avatar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Course Heading
              Text(
                'Course',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeights.bold,
                  color: isDarkMode ? MathColorTheme().white : Colors.black,
                ),
              ),

              const SizedBox(height: 24),

              // Unit Box with Play Button
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? MathColorTheme().seaBlue
                      : MathColorTheme().lighterGray,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 34,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          color: isDarkMode
                              ? MathColorTheme().darkunitCard
                              : MathColorTheme().grey9D),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: MathColorTheme().white,
                            ),
                            const Spacer(),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: MathColorTheme().white,
                            ),
                            SizedBoxes.horizontalMicro,
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: MathColorTheme().white,
                            ),
                            SizedBoxes.horizontalMicro,
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: MathColorTheme().white,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Unit #1',
                            style: TextStyle(
                              fontSize: 20,
                              color: isDarkMode
                                  ? MathColorTheme().white
                                  : Colors.black,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: MathColorTheme().green,
                            child: IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  MathAssets.play,
                                  height: 14,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Text(
                '1. Vocabulaire usuel des suites',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? MathColorTheme().white : Colors.black,
                ),
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'A. ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Sens de variation d’une suite',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode ? MathColorTheme().white : Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: isDarkMode
                        ? MathColorTheme().seaBlue
                        : MathColorTheme().lighterGray,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: MathColorTheme().lightBorder)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 18.0,
                      ),
                      decoration: BoxDecoration(
                        color: MathColorTheme().green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Définitions',
                        style: TextStyle(
                          color: MathColorTheme().white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '(un) est une suite définie sur l’ensemble ℕ des nombres entiers naturels\n\n'
                      '• Dire que la suite (  ) est croissante signifie que, pour tout entier naturel n, '
                      'u(n+1) ≥ u(n)\n\n'
                      '• Dire que la suite (  ) est décroissante signifie que, pour tout entier naturel n, '
                      'u(n+1) ≤ u(n)\n',
                      style: TextStyle(
                        color:
                            isDarkMode ? MathColorTheme().white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
