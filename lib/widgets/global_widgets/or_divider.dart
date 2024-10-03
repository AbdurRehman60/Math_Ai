import '../../constants/constant_exports.dart';
class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Divider(
              color: MathColorTheme().lightBlack.withOpacity(0.3),
              thickness: 1.5,
            ),
          ),
        ),
        SizedBoxes.horizontalMicro,
        Text('OR',
            style: MathTextTheme().heading6.copyWith(
                fontWeight: FontWeight.w500,
                color: MathColorTheme().black.withOpacity(0.3),
                fontSize: 15)),
        SizedBoxes.horizontalMicro,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Divider(
              color: MathColorTheme().gray,
              thickness: 1,
            ),
          ),
        ),
      ],
    );
  }
}


class Dividerr extends StatelessWidget {
  const Dividerr({super.key, required this.enablePadding});
  final bool enablePadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: enablePadding ?12 : 0 ),
      child: Divider(height: 1,color: MathColorTheme().lightIcon.withOpacity(0.2),),
    );
  }
}

