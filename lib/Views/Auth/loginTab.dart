import 'package:flutter/material.dart';
import 'package:shopsavvy/Controllers/Auth/LoginController.dart';
import 'package:shopsavvy/Models/Strings/login_screen.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Models/Utils/Common.dart';
import 'package:shopsavvy/Models/Utils/Images.dart';
import 'package:shopsavvy/Models/Validation/FormValidation.dart';
import 'package:shopsavvy/Views/Widgets/custom_button.dart';
import 'package:shopsavvy/Views/Widgets/custom_text_form_field.dart';

class LoginTab extends StatefulWidget {
  LoginTab({Key? key}) : super(key: key);

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final LoginController _loginController = LoginController();
  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Form(
          key: _keyForm,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: displaySize.width * 0.4,
                          height: displaySize.width * 0.4,
                          child: Center(
                            child: SizedBox(
                              width: displaySize.width * 0.4,
                              child: Image.asset(logo),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Center(
                          child: Text(
                            Login_title,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Center(
                          child: Text(
                            Login_title_2,
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: CustomTextFormField(
                              readOnly: false,
                              height: 5.0,
                              controller: _username,
                              backgroundColor: color9,
                              iconColor: color3,
                              isIconAvailable: true,
                              hint: 'Email Address / Username',
                              icon: Icons.email_outlined,
                              textInputType: TextInputType.text,
                              validation: (value) =>
                                  FormValidation.notEmptyValidation(value,
                                      'Invalid Email Address / Username'),
                              obscureText: false),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: CustomTextFormField(
                              readOnly: false,
                              height: 5.0,
                              controller: _password,
                              backgroundColor: color9,
                              iconColor: color3,
                              isIconAvailable: true,
                              hint: 'Password',
                              icon: Icons.lock_outline,
                              textInputType: TextInputType.text,
                              validation: (value) =>
                                  FormValidation.passwordValidation(value),
                              obscureText: true),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45.0, vertical: 5.0),
                          child: CustomButton(
                              buttonText: Login_button_text,
                              textColor: color6,
                              backgroundColor: colorPrimary,
                              isBorder: false,
                              borderColor: color6,
                              onclickFunction: () async {
                                FocusScope.of(context).unfocus();
                                if (_keyForm.currentState!.validate()) {
                                  await _loginController.commonLogin(context, {
                                    'email': _username.text,
                                    'password': _password.text
                                  });
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 30.0,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
