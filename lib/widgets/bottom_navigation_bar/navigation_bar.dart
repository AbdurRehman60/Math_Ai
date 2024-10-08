import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mathematics_ai/constants/assets.dart';
import 'package:mathematics_ai/constants/color_theme.dart';
import 'package:mathematics_ai/providers/theme_provider.dart';
import 'package:mathematics_ai/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../screens/home/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
 State<StatefulWidget> createState() {
    return _BottomNavBarState();
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _bottomNavIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CoursesScreen(),
    const SettingsScreen(),
  ];

  final iconAssets = <String>[
    MathAssets.home,
    MathAssets.course,
    MathAssets.profile1,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _bottomNavIndex,
              children: _screens,
            ),
          ),
        ],
      ),


      bottomNavigationBar: CurvedNavigationBar(
        index: _bottomNavIndex,
        height: 70.0,
        items: <Widget>[
          Center(child: _buildNavItem(0)),
          Center(child: _buildNavItem(1)),
          Center(child: _buildNavItem(2)),
        ],
        color:Provider.of<ThemeProvider>(context,).isDarkMode ? MathColorTheme().seaBlue : MathColorTheme().lightGray,
        buttonBackgroundColor: MathColorTheme().green,
        backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? MathColorTheme().darkScaffold  : Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),

    );
  }

  Widget _buildNavItem(int index) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        _bottomNavIndex == index ? MathColorTheme().white : MathColorTheme().lightIcon,
        BlendMode.srcIn,
      ),
      child: Image.asset(
        iconAssets[index],
        width: 24,
        height: 24,
      ),
    );
  }
}


// Courses Screen Widget
class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor:
      isDarkMode ? MathColorTheme().darkScaffold : Colors.white,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_outlined,
              size: 80,
              color: Colors.black,
            ),
            SizedBox(height: 16),
            Text(
              'Course lesson',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Lorem ipsum dolor sit amet consectetur. '
                    'Sit mattis erat id aliquet cras quam ultrices.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
