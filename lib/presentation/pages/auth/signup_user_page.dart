import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:spag/presentation/widgets/form_container_widget.dart';
import 'package:spag/presentation/widgets/page_structure_widget.dart';
import 'package:spag/models/users/user.dart';
import 'package:spag/providers/user_provider.dart';

class SignupUserPage extends StatefulWidget {
  const SignupUserPage({
    super.key,
  });

  @override
  State<SignupUserPage> createState() => _SignupUserPageState();
}

class _SignupUserPageState extends State<SignupUserPage> {
  bool _isLoading = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonPageStructure(
      title: AppLocalizations.of(context)!.signup,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.signup_user_info,
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                hintText: AppLocalizations.of(context)!.signup_username,
                controller: _usernameController,
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                hintText: AppLocalizations.of(context)!.login_email,
                controller: _emailController,
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                hintText: AppLocalizations.of(context)!.login_pass,
                controller: _passwordController,
                isPasswordField: true,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                onPressed: _signUp,
                icon: _isLoading
                    ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary)
                    : const Icon(Icons.person_add),
                label: _isLoading
                    ? const Text("")
                    : Text(AppLocalizations.of(context)!.signup),
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
                  Text(AppLocalizations.of(context)!.signup_login),
                  const SizedBox(width: 5),
                  GestureDetector(
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        ModalRoute.withName("/Home"),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    UserModel user = UserModel.forInsert(name: username, email: email);

    user.signUp(password).then((value) {
      setState(() => _isLoading = false);
      if (user.isLogged()) {
        Provider.of<UserProvider>(context, listen: false).user = user;
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/user',
          ModalRoute.withName("/Home"),
        );
      } else {
        print("Not logged in LOL");
      }
    });

    // TODO - Find sense
    setState(() {
      _isLoading = false;
    });
  }
}
