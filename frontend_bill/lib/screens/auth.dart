import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:general/main.dart';
import 'package:general/widget/dialog_box.dart';
import 'package:general/widget/my_button.dart';
import 'package:general/widget/text_field.dart';
import 'package:general/screens/home.dart';
import 'package:general/storage/flutter_secure_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final MySecureStorage _secureStorage = MySecureStorage();

  bool _isLogin = true;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    String? localeCode = await _secureStorage.readLocale();
    if (localeCode != null) {
      Locale newLocale = Locale(localeCode);
      MyApp.setLocale(context, newLocale);
    }
  }

  Future<void> signIn(BuildContext context) async {
    final validPassword = _passwordController.text.length >= 6;
    const emailPattern = r'^[^@]+@[^@]+\.[^@]+$';
    final emailRegExp = RegExp(emailPattern);
    final validEmail = emailRegExp.hasMatch(_emailController.text.trim());

    if (_formKey.currentState!.validate() && validEmail && validPassword) {
      final savedEmail = await _secureStorage.readEmail();
      final savedPassword = await _secureStorage.readPassword();

      if (_emailController.text == savedEmail &&
          _passwordController.text == savedPassword) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        MyDialogBox(context, AppLocalizations.of(context)!.invalid_login,
                AppLocalizations.of(context)!.email_password_incorrect)
            .showAlertDialog();
      }
    } else {
      MyDialogBox(context, AppLocalizations.of(context)!.invalid_login,
              AppLocalizations.of(context)!.email_password_invalid)
          .showAlertDialog();
    }
  }

  Future<void> signUp(BuildContext context) async {
    final validPassword = _passwordController.text.length >= 6;
    const emailPattern = r'^[^@]+@[^@]+\.[^@]+$';
    final emailRegExp = RegExp(emailPattern);
    final validEmail = emailRegExp.hasMatch(_emailController.text.trim());

    if (_formKey.currentState!.validate() && validEmail && validPassword) {
      _formKey.currentState!.save();
      final email = _emailController.text;
      final password = _passwordController.text;

      await _secureStorage.writeEmailAndPassword(email, password);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.invalid_login),
          content: Text(AppLocalizations.of(context)!.email_password_incorrect),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.okay),
            )
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.translate),
              onSelected: (value) async {
                Locale newLocale;
                if (value == 1) {
                  newLocale = const Locale('en');
                } else if (value == 2) {
                  newLocale = const Locale('hi');
                } else {
                  newLocale = const Locale('gu');
                }

                await _secureStorage.saveLocale(newLocale.languageCode);
                MyApp.setLocale(context, newLocale);
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Text(AppLocalizations.of(context)!.english),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(AppLocalizations.of(context)!.hindi),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Text(AppLocalizations.of(context)!.gujrati),
                  ),
                ];
              })
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                _isLogin
                    ? AppLocalizations.of(context)!.login_here
                    : AppLocalizations.of(context)!.register_here,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (!_isLogin)
                        MyTextField(
                          preFixIcon: const Icon(Icons.person),
                          label: AppLocalizations.of(context)!.name,
                          obscureText: false,
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                        ),
                      const SizedBox(height: 20),
                      MyTextField(
                        label: AppLocalizations.of(context)!.email,
                        obscureText: false,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        preFixIcon: const Icon(Icons.email),
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        preFixIcon: const Icon(Icons.password),
                        label: AppLocalizations.of(context)!.password,
                        obscureText: true,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 10),
                      MyButton(
                        text: _isLogin
                            ? AppLocalizations.of(context)!.login
                            : AppLocalizations.of(context)!.register,
                        onTap: () =>
                            _isLogin ? signIn(context) : signUp(context),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: _isLogin
                            ? AppLocalizations.of(context)!.dont_have_account
                            : AppLocalizations.of(context)!
                                .already_have_account,
                        children: [
                          TextSpan(
                            text: _isLogin
                                ? AppLocalizations.of(context)!.register
                                : AppLocalizations.of(context)!.login,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
