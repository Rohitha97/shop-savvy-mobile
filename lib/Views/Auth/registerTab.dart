import 'package:flutter/material.dart';
import 'package:shopsavvy/Controllers/Auth/RegisterController.dart';
import 'package:shopsavvy/Models/Strings/business_register_screen.dart';
import 'package:shopsavvy/Models/Strings/main_screen.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Models/Utils/Common.dart';
import 'package:shopsavvy/Models/Utils/Routes.dart';
import 'package:shopsavvy/Models/Utils/Utils.dart';
import 'package:shopsavvy/Models/Validation/FormValidation.dart';
import 'package:shopsavvy/Views/Widgets/custom_back_button.dart';
import 'package:shopsavvy/Views/Widgets/custom_button.dart';
import 'package:shopsavvy/Views/Widgets/custom_text_form_field.dart';

class RegisterTab extends StatefulWidget {
  RegisterTab({Key? key}) : super(key: key);

  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  bool termsAndConditionCheck = false;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm_password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final RegisterController _registerController = RegisterController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  Signup_title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: CustomTextFormField(
                              readOnly: false,
                              height: 5.0,
                              controller: _name,
                              backgroundColor: color9,
                              iconColor: color3,
                              isIconAvailable: true,
                              hint: 'Full Name',
                              icon: Icons.person_pin_circle_outlined,
                              textInputType: TextInputType.text,
                              validation: (value) =>
                                  FormValidation.notEmptyValidation(
                                      value, "Please enter name"),
                              obscureText: false),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: CustomTextFormField(
                              readOnly: false,
                              height: 5.0,
                              controller: _email,
                              backgroundColor: color9,
                              iconColor: color3,
                              isIconAvailable: true,
                              hint: 'Email Address',
                              icon: Icons.email_outlined,
                              textInputType: TextInputType.emailAddress,
                              validation: (value) =>
                                  FormValidation.emailValidation(
                                      value, "Invalid Email Address"),
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
                              icon: Icons.lock_open,
                              textInputType: TextInputType.text,
                              validation: (value) =>
                                  FormValidation.passwordValidation(value),
                              obscureText: true),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: CustomTextFormField(
                              readOnly: false,
                              height: 5.0,
                              controller: _confirm_password,
                              backgroundColor: color9,
                              iconColor: color3,
                              isIconAvailable: true,
                              hint: 'Confirm Password',
                              icon: Icons.lock_open,
                              textInputType: TextInputType.text,
                              validation: (value) =>
                                  FormValidation.retypePasswordValidation(
                                      value, _password.text),
                              obscureText: true),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: Checkbox(
                                  checkColor: color3,
                                  fillColor: MaterialStateProperty.all(color9),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                  value: termsAndConditionCheck,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      termsAndConditionCheck = value!;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: SizedBox(
                                  width: displaySize.width * 0.65,
                                  child: Text(
                                    Signup_Checkbox_termsAndConditions_lbl,
                                    style: TextStyle(
                                        color: color8,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45.0, vertical: 20.0),
                          child: CustomButton(
                              buttonText: SignUp_title,
                              textColor: color6,
                              backgroundColor: colorPrimary,
                              isBorder: false,
                              borderColor: color6,
                              // onclickFunction: () => CustomUtils.showSnackBar(
                              //     context,
                              //     "Not Connected to the Server",
                              //     CustomUtils.SUCCESS_SNACKBAR),
                              onclickFunction: () {
                                FocusScope.of(context).unfocus();
                                if (termsAndConditionCheck == true) {
                                  if (_formKey.currentState!.validate()) {
                                    _registerController.register(context, {
                                      "name": _name.text,
                                      "email": _email.text,
                                      "password": _password.text,
                                      "password_confirmation":
                                          _confirm_password.text
                                    }).then((value) {
                                      if (value == true) {
                                        _formKey.currentState!.reset();
                                        _name.text = '';
                                        _email.text = '';
                                        _password.text = '';
                                        _confirm_password.text = '';
                                      }
                                    });
                                  }
                                } else {
                                  CustomUtils.showSnackBar(
                                      context,
                                      "Please Accept the Terms and Conditions for Proceed",
                                      CustomUtils.ERROR_SNACKBAR);
                                }
                              }),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
