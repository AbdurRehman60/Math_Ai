import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/assets.dart';
import '../../../constants/color_theme.dart';
import '../../../constants/sized_boxes.dart';
import '../../../constants/text_theme.dart';
import '../../../providers/theme_provider.dart';
import '../../../models/menu_model.dart';

class ExerciseCard extends StatefulWidget {
  final Color color;
  final String title;
  final int exercises;
  final List<SubMenuModel> submenus;
  final int order;

  const ExerciseCard({
    super.key,
    required this.color,
    required this.title,
    required this.exercises,
    required this.submenus,
    required this.order,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool _isExpanded = false;

  final List<String> coverPaths = [
    MathAssets.coverA,
    MathAssets.coverB,
    MathAssets.coverC,
    MathAssets.coverD,
    MathAssets.coverE,
    MathAssets.coverF,
    MathAssets.coverG,
    MathAssets.coverH,
    MathAssets.coverI,
    MathAssets.coverJ,




  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: _isExpanded ? 435 : 350,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: isDarkMode ? MathColorTheme().seaBlue : widget.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  height: 170,
                  color: isDarkMode
                      ?  Colors.white : Colors.black,
                  _getCardBackgroundImage(widget.order),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? MathColorTheme().darkScaffold
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 42,
                        child: Center(
                          child: Text(
                            '${widget.exercises} Exercises',
                            style: TextStyle(
                              color: isDarkMode
                                  ? MathColorTheme().white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded; // Toggle expansion
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: isDarkMode
                              ? MathColorTheme().darkScaffold
                              : Colors.white,
                          child: _isExpanded
                              ? Icon(
                            Icons.remove,
                            color: isDarkMode ? Colors.white : Colors.black,
                          )
                              : Icon(
                            Icons.add,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBoxes.verticalBig,
            Divider(
              height: 2,
              color: isDarkMode
                  ? Colors.white.withOpacity(0.6)
                  : MathColorTheme().lightBlack.withOpacity(0.35),
              endIndent: 12,
              indent: 12,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.title,
                style: MathTextTheme().body.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBoxes.verticalTiny,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Lorem ipsum dolor sit amet consectetur. Ac est amet etiam eu enim sit. '
                    'Sit mattis erat id aliquet cras quam ultricies ultrices euismod.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color:
                  isDarkMode ? Colors.white.withOpacity(0.7) : Colors.black54,
                ),
              ),
            ),
            if (_isExpanded) ...[
              Divider(
                height: 2,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.6)
                    : MathColorTheme().lightBlack.withOpacity(0.35),
                endIndent: 12,
                indent: 12,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildExpandableContent(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Logic to get the card background image based on the order
  String _getCardBackgroundImage(int order) {
    return coverPaths[order % coverPaths.length];
  }
  Widget _buildExpandableContent() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;

    return Column(
      children: widget.submenus.isNotEmpty
          ? widget.submenus.map((submenu) {
        return ListTile(
          title: Text(
            submenu.title,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/course');
          },
        );
      }).toList()
          : [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'No Submenus Available',
            style: TextStyle(
              color: isDarkMode ? Colors.white54 : Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
