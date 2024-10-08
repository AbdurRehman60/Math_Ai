import 'package:mathematics_ai/widgets/global_widgets/or_divider.dart';
import 'package:provider/provider.dart';
import 'package:mathematics_ai/constants/constant_exports.dart';
import 'package:mathematics_ai/providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDarkMode ? MathColorTheme().darkScaffold : Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0)
                  .copyWith(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    isDarkMode ? MathAssets.darkLogo : MathAssets.logo,
                    height: 40,
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor:
                        Provider.of<ThemeProvider>(context, listen: false)
                                .isDarkMode
                            ? MathColorTheme().darkField.withOpacity(0.8)
                            : Colors.grey.shade100,
                    child: ClipOval(
                      child: Image.asset(
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
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCard(
                        context,
                        isDarkMode: isDarkMode,
                        icon: MathAssets.courseBook,
                        title: 'Course lesson',
                        description:
                            'Lorem ipsum dolor sit amet consectetur. Ac est amet etiam eu enim sit.',
                        backgroundColor: isDarkMode
                            ? MathColorTheme().darkField
                            : MathColorTheme().lightKhaki,
                        onTap: () {
                          Navigator.pushNamed(context, '/level');
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildCard(
                        context,
                        isDarkMode: isDarkMode,
                        icon: MathAssets.exerciseArc,
                        title: 'Math exercises',
                        description:
                            'Lorem ipsum dolor sit amet consectetur. Ac est amet etiam eu enim sit.',
                        backgroundColor: isDarkMode
                            ? MathColorTheme().darkField
                            : MathColorTheme().lightBlue,
                        onTap: () {
                          Navigator.pushNamed(context, '/level');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required bool isDarkMode,
    required String icon,
    required String title,
    required String description,
    required Color backgroundColor,
    required VoidCallback onTap, // Added onTap as a required parameter
  }) {
    return InkWell(
      onTap: onTap, // Assign the passed onTap function
      child: Container(
        height: 407, // Adjusted height for the card
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Center the icon inside the card
            Expanded(
              child: Center(
                child: Image.asset(
                  icon,
                  height: 80, // Adjust icon size as necessary
                  width: 80, // Adjust icon size as necessary
                  color: isDarkMode
                      ? MathColorTheme().white
                      : MathColorTheme().black,
                ),
              ),
            ),
            // Title and Description at the bottom
            const Dividerr(enablePadding: false),
            SizedBoxes.vertical15Px,
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: MathTextTheme().body.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode
                          ? MathColorTheme().white
                          : MathColorTheme().black,
                    ),
              ),
            ),
            const SizedBox(height: 8), // Space between title and description

            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                description,
                style: MathTextTheme().body.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode
                          ? Colors.grey.shade400
                          : MathColorTheme().black,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
