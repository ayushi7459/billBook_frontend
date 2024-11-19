import 'package:flutter/material.dart';
import 'package:general/widget/my_button.dart';
import 'package:general/widget/text_field.dart';
import 'package:general/models/user.dart';
import 'package:general/widget/dialog_box.dart';
import 'package:general/widget/drop_down_btn.dart';
import 'package:general/widget/data_picker.dart';
import 'package:general/widget/check_box_btn.dart';
import 'package:general/enum/my_enum.dart';
import 'package:general/storage/shared_pref.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NewUser extends StatefulWidget {
  const NewUser({super.key, required this.onAddUser});

  final void Function(User user) onAddUser;

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  late IsGender genderIs = IsGender.Male;
  bool isMan = true;
  bool isFemale = false;
  bool isOther = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submitData() async {
    final enteredMobile = double.tryParse(_mobileController.text);
    final validMobile =
        enteredMobile != null && _mobileController.text.length == 10;
    const emailPattern = r'^[^@]+@[^@]+\.[^@]+$';
    final emailRegExp = RegExp(emailPattern);
    final validEmail = emailRegExp.hasMatch(_emailController.text.trim());

    await saveUserName(_nameController.text);
    await saveCredentials(_emailController.text, _passwordController.text);
    await saveMobileGender(_mobileController.text, genderIs.name);

    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _mobileController.text.trim().isEmpty ||
        !validMobile ||
        !validEmail) {
      _formKey.currentState!.save();
      MyDialogBox(
        context,
       AppLocalizations.of(context)!.invalid_input,
        AppLocalizations.of(context)!.please_enter_valid_values,
      ).showAlertDialog();
      return;
    }
    widget.onAddUser(
      User(
        firstName: _nameController.text,
        email: _emailController.text,
        phone: _mobileController.text,
        gender: genderIs.name,
        birthDate: _dateController.text,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.add_user,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                MyTextField(
                  preFixIcon: Icon(Icons.person),
                  controller: _nameController,
                  label: AppLocalizations.of(context)!.name,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  preFixIcon: Icon(Icons.email),
                  controller: _emailController,
                  label: AppLocalizations.of(context)!.email,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  preFixIcon: Icon(Icons.phone_android),
                  controller: _mobileController,
                  label: AppLocalizations.of(context)!.mobile,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyDropDownBtn<IsGender>(
                  prefixIcon: Icon(Icons.wc),
                  value: genderIs,
                  items: IsGender.values,
                  getLabel: (gender) => gender.name,
                  onChanged: (selectedGender) {
                    setState(() {
                      genderIs = selectedGender!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const MyDatePicker(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("${AppLocalizations.of(context)!.man}: "),
                    MyCheckBox(
                        myValue: isMan,
                        onChanged: (bool? value) {
                          setState(() {
                            isMan = value ?? false;
                            if (isMan) {
                              isFemale = false;
                              isOther = false;
                            }
                          });
                        }),
                     Text("${AppLocalizations.of(context)!.female}: "),
                    MyCheckBox(
                        myValue: isFemale,
                        onChanged: (bool? value) {
                          setState(() {
                            isFemale = value ?? false;
                            if (isFemale) {
                              isMan = false;
                              isOther = false;
                            }
                          });
                        }),
                     Text("${AppLocalizations.of(context)!.other}: "),
                    MyCheckBox(
                        myValue: isOther,
                        onChanged: (bool? value) {
                          setState(() {
                            isOther = value ?? false;
                            if (isOther) {
                              isFemale = false;
                              isMan = false;
                            }
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(text: AppLocalizations.of(context)!.cancel, onTap: Navigator.of(context).pop),
              const SizedBox(
                width: 10,
              ),
              MyButton(text: AppLocalizations.of(context)!.save, onTap: _submitData)
            ],
          )
        ],
      ),
    );
  }
}