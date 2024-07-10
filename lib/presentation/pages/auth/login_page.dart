import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:spag/models/users/abstract_user.dart';
import 'package:spag/presentation/widgets/form_container_widget.dart';
import 'package:spag/presentation/widgets/page_structure_widget.dart';
import 'package:spag/providers/user_provider.dart';
import 'package:spag/validators/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return CommonPageStructure(
      title: localizations.login,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FormContainerWidget(
                  hintText: localizations.login_email,
                  controller: _emailController,
                  isPasswordField: false,
                  validator: (value) =>
                      EmailValidator.validate(value, localizations),
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  hintText: localizations.login_pass,
                  controller: _passwordController,
                  isPasswordField: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  onPressed: _signIn,
                  icon: _isLoading
                      ? CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onPrimary)
                      : const Icon(Icons.login),
                  label:
                      _isLoading ? const Text("") : Text(localizations.login),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(localizations.login_signup),
                    const SizedBox(width: 5),
                    GestureDetector(
                      child: Text(
                        localizations.signup,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid:
      setState(() {
        _isLoading = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;

      await AbstractUser.fromEmail(email).then((user) {
        setState(() => _isLoading = false);

        if (user == null) {
          print("Email not found in our DB");
          return;
        }

        user.logIn(password).then((logged) {
          if (logged) {
            Provider.of<UserProvider>(context, listen: false).user = user;
            if (user.role == Role.gym) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/gym',
                ModalRoute.withName("/Home"),
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/user',
                ModalRoute.withName("/Home"),
              );
            }
          } else {
            print("Authentication problem of the user ${user.name}");
          }
        });
      });

      // TODO - Find sense
      setState(() {
        _isLoading = false;
      });
    }
  }
}
