import '../../constants/constant_exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, required this.onTap, required this.buttonColor});
  final String title;
  final void Function() onTap;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style:
              MathTextTheme().body.copyWith(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
class CustomButton2 extends StatelessWidget {
  const CustomButton2({super.key, required this.title, required this.onTap, required this.buttonColor});
  final String title;
  final void Function() onTap;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            side:  BorderSide(
              color: MathColorTheme().errorRed,
              width: 1
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style:
          MathTextTheme().body.copyWith(color: MathColorTheme().errorRed, fontSize: 16,fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
