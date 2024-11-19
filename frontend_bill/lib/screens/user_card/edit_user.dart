import 'package:flutter/material.dart';
import 'package:general/widget/my_button.dart';
import 'package:general/widget/text_field.dart';
import 'package:general/models/user.dart';
import 'package:general/widget/dialog_box.dart';
import 'package:general/services/dio_http.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Edituser extends StatefulWidget {
  const Edituser({super.key, required this.user, required this.onEdit});
  final User user;
  final Function(User) onEdit;

  @override
  State<Edituser> createState() => _EdituserState();
}

class _EdituserState extends State<Edituser> {
  late var _nameController = TextEditingController();
  late var _emailController = TextEditingController();
  late var _mobileController = TextEditingController();
  late var _genderController = TextEditingController();
  late var _dateController = TextEditingController();
  final DioHttp dioHttp = DioHttp();

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.user.firstName);
    _emailController = TextEditingController(text: widget.user.email);
    _mobileController = TextEditingController(text: widget.user.phone);
    _genderController = TextEditingController(text: widget.user.gender);
    _dateController = TextEditingController(text: widget.user.birthDate);
    super.initState();
  }

  void _editData(context) async {
    const emailPattern = r'^[^@]+@[^@]+\.[^@]+$';
    final emailRegExp = RegExp(emailPattern);
    final validEmail = emailRegExp.hasMatch(_emailController.text.trim());

    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _mobileController.text.trim().isEmpty ||
        _genderController.text.trim().isEmpty ||
        !validEmail) {
      MyDialogBox(context, AppLocalizations.of(context)!.invalid_input, AppLocalizations.of(context)!.please_enter_valid_values)
          .showAlertDialog();
      return;
    }
    final updatedUser = User(
      id: widget.user.id,
      firstName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _mobileController.text.trim(),
      gender: _genderController.text.trim(),
      birthDate: _dateController.text.trim(),
    );

    try {
      final success = await dioHttp.updateUser(updatedUser);
      if (success) {
        widget.onEdit(updatedUser);
        Navigator.pop(context);
      } else {
        MyDialogBox(context, AppLocalizations.of(context)!.update_failed, AppLocalizations.of(context)!.failed_to_update_user)
            .showAlertDialog();
      }
    } catch (e) {
      MyDialogBox(context, AppLocalizations.of(context)!.error, "${AppLocalizations.of(context)!.error_updating_user}: $e")
          .showAlertDialog();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.edit_user,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            preFixIcon: const Icon(Icons.person),
            controller: _nameController,
            label: AppLocalizations.of(context)!.name,
            obscureText: false,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            preFixIcon: const Icon(Icons.email),
            controller: _emailController,
            label:AppLocalizations.of(context)!.email,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            preFixIcon: const Icon(Icons.phone_android),
            controller: _mobileController,
            label:AppLocalizations.of(context)!.mobile,
            obscureText: false,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            preFixIcon: const Icon(Icons.wc),
            controller: _genderController,
            label:AppLocalizations.of(context)!.gender,
            obscureText: false,
            keyboardType: TextInputType.name,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                MyButton(text: AppLocalizations.of(context)!.cancel, onTap: Navigator.of(context).pop),
                const SizedBox(
                  width: 10,
                ),
                MyButton(
                    text: AppLocalizations.of(context)!.edit,
                    onTap: () {
                      _editData(context);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}