import '../../constants/constant_exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, required this.onTap});
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MathColorTheme().green,
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
