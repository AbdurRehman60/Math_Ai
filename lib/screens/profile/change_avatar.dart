import 'package:mathematics_ai/constants/constant_exports.dart';
import '../../widgets/global_widgets/custom_button.dart';

class ChangeAvatarScreen extends StatefulWidget {
  const ChangeAvatarScreen({super.key});

  @override
  _ChangeAvatarScreenState createState() => _ChangeAvatarScreenState();
}

class _ChangeAvatarScreenState extends State<ChangeAvatarScreen> {
  double _avatarSize = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              MathAssets.logo,
              height: 40,
            ),
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.shade100,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Change avatar',
              style: MathTextTheme().heading1.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 8),
            Text(
              'U can add or remove your picture',
              style: MathTextTheme().body.copyWith(
                color: MathColorTheme().neutral400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
              },
              child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: MathColorTheme().lightIcon, width: 1)
              ),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(MathAssets.photo, height: 32, width: 32),
                    const SizedBox(height: 8),
                    Text(
                      '+ Add picture',
                      style: MathTextTheme().body.copyWith(fontSize: 16),
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
              Image.asset(MathAssets.photo,height: 18,width: 18,),
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
                      onChanged: (value) {
                        setState(() {
                          _avatarSize = value;
                        });
                      },
                    ),
                  ),
                ),
                Image.asset(MathAssets.photo,height: 24,width: 24,),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                CustomButton(
                  title: 'Save',
                  onTap: () {

                  },
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: MathColorTheme().errorRed, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                    child: Text(
                      'Delete',
                      style: MathTextTheme().body.copyWith(
                        color: MathColorTheme().errorRed,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }
}
