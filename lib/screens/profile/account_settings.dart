import '../../constants/constant_exports.dart';
import '../../widgets/global_widgets/custom_button.dart';
import '../../widgets/global_widgets/custom_textfield.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController referralController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isUsernameEditable = false;
  bool isEmailEditable = false;
  bool isPhoneEditable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          'Account Settings',
          style: MathTextTheme().body.copyWith(fontSize: 28),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              const SizedBox(height: 22),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/avatar');
                    },
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.grey.shade100,
                      child: ClipOval(
                        child: Image.asset(
                          MathAssets.profile,
                          width: 38,
                          height: 38,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Peter Anderson",
                        style: MathTextTheme().heading1.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Member since 7/1/2023",
                        style: MathTextTheme()
                            .body
                            .copyWith(color: MathColorTheme().neutral400),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Username',
                style: MathTextTheme().body.copyWith(fontSize: 16),
              ),
               SizedBoxes.verticalTiny,
              CustomTextField(
                controller: usernameController,
                filled: true,
                readOnly: !isPhoneEditable,
                suffixIcon: IconButton(
                  icon: Image.asset(MathAssets.edit,height: 16,),
                  onPressed: () {
                    setState(() {
                      isPhoneEditable = !isPhoneEditable;
                    });
                  },
                ),
                fillColor: MathColorTheme().neutral200,
              ),
              SizedBoxes.vertical15Px,
              Text(
                'Username',
                style: MathTextTheme().body.copyWith(fontSize: 16),
              ),
              SizedBoxes.verticalTiny,
              CustomTextField(
                controller: usernameController,
                filled: true,
                readOnly: !isPhoneEditable,
                suffixIcon: IconButton(
                  icon: Image.asset(MathAssets.edit,height: 16,),
                  onPressed: () {
                    setState(() {
                      isPhoneEditable = !isPhoneEditable;
                    });
                  },
                ),
                fillColor: MathColorTheme().neutral200,
              ),
              SizedBoxes.vertical15Px,

              // Email Field
              Text(
                'Referral link',
                style: MathTextTheme().body.copyWith(fontSize: 16),
              ),
              SizedBoxes.verticalTiny,
              CustomTextField(
                controller: emailController,
                filled: true,
                readOnly: !isEmailEditable,
                suffixIcon: IconButton(
                  icon: Image.asset(MathAssets.copy,height: 17,),
                  onPressed: () {
                    setState(() {
                      isEmailEditable = !isEmailEditable;
                    });
                  },
                ),
                fillColor: MathColorTheme().neutral200,
              ),
              SizedBoxes.vertical15Px,
              Text(
                'Phone Number',
                style: MathTextTheme().body.copyWith(fontSize: 16),
              ),
              SizedBoxes.verticalTiny,
              CustomTextField(
                controller: phoneController,
                filled: true,
                readOnly: !isPhoneEditable,
                suffixIcon: IconButton(
                  icon: Image.asset(MathAssets.edit,height: 16,),
                  onPressed: () {
                    setState(() {
                      isPhoneEditable = !isPhoneEditable;
                    });
                  },
                ),
                fillColor: MathColorTheme().neutral200,
              ),
              const SizedBox(height: 32),

              // Save Button
              CustomButton(
                title: 'Save',
                onTap: () {
                  // Handle save action
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
