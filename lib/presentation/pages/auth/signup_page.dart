import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spag/presentation/widgets/page_structure_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({
    super.key,
  });

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String current = "";

  @override
  Widget build(BuildContext context) {
    return CommonPageStructure(
      title: AppLocalizations.of(context)!.signup,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.signup_user_role,
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(
                height: 30,
              ),
              RadioMenuButton(
                value: "user",
                groupValue: current,
                onChanged: _select,
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  elevation: const MaterialStatePropertyAll(2),
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.secondaryContainer),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      height: 50,
                      width: 100,
                      child: Image(
                        image: AssetImage('assets/images/user2.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 60,
                    ),
                    Text(
                      AppLocalizations.of(context)!.user,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RadioMenuButton(
                value: "gym",
                groupValue: current,
                onChanged: _select,
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  elevation: const MaterialStatePropertyAll(2),
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.secondaryContainer),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      height: 50,
                      width: 100,
                      child: Image(
                        image: AssetImage('assets/images/gym.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 60,
                    ),
                    Text(
                      AppLocalizations.of(context)!.gym,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                onPressed: current == ""
                    ? null
                    : () {
                        if (current == "user") {
                          Navigator.pushNamed(context, '/signupUser');
                        } else if (current == "gym") {
                          Navigator.pushNamed(context, '/signupGym');
                        } else {}
                      },
                icon: const Icon(Icons.arrow_forward),
                label: Text(AppLocalizations.of(context)!.next),
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

  void _select(String? value) async {
    setState(() {
      current = value!;
    });
  }
}
