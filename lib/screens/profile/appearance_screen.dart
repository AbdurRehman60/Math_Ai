
import 'package:mathematics_ai/widgets/global_widgets/or_divider.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../constants/constant_exports.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDarkMode ? MathColorTheme().darkScaffold : MathColorTheme().white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
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
                      backgroundImage: AssetImage(
                        MathAssets.profile,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Center(
                  child: Column(
                    children: [
                      Row(
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
                          SizedBoxes.horizontal15Px,
                          Text(
                            'Appearance',
                            style: MathTextTheme().heading1.copyWith(
                                  fontSize: 24,
                                  color: isDarkMode
                                      ? MathColorTheme().white
                                      : MathColorTheme().black,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. '
                        'Sodales consequat rhoncus volutpat massa in.',
                        textAlign: TextAlign.center,
                        style: MathTextTheme().body.copyWith(
                              fontSize: 14,
                              color: isDarkMode
                                  ? MathColorTheme().white
                                  : MathColorTheme().neutral400,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Dark Theme Card
                _buildThemeCard(
                  context,
                  'Original Dark Theme',
                  MathAssets.darkApp,
                  isSelected: isDarkMode,
                  onTap: () {
                    themeProvider.toggleTheme(true);
                  },
                ),
                const SizedBox(height: 16),

                // Light Theme Card
                _buildThemeCard(
                  context,
                  'White Theme',
                  MathAssets.lightApp,
                  isSelected: !isDarkMode,
                  onTap: () {
                    themeProvider.toggleTheme(false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeCard(
    BuildContext context,
    String title,
    String imagePath, {
    required bool isSelected,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                ? MathColorTheme().darkThemeCard
                : MathColorTheme().lightGray,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode
                    ? MathColorTheme().white.withOpacity(0.15)
                    : MathColorTheme().lightBlack.withOpacity(0.15))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    imagePath,
                    height: 174,
                    width: 270,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              const Dividerr(enablePadding: false),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: MathTextTheme().heading1.copyWith(
                            fontSize: 16,
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? MathColorTheme().white
                                    : MathColorTheme().black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    // Radio button
                    Radio<bool>(
                      value: isSelected,
                      groupValue: true,
                      activeColor: MathColorTheme().green,
                      onChanged: (bool? value) {
                        if (value == true) {
                          onTap();
                        }
                      },
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
