import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spag/models/location.dart';
import 'package:spag/presentation/pages/auth/signup_gym_payment_page.dart';
import 'package:spag/presentation/widgets/form_container_widget.dart';
import 'package:spag/presentation/widgets/page_structure_widget.dart';

class SignupGymPage extends StatefulWidget {
  const SignupGymPage({super.key});

  @override
  State<SignupGymPage> createState() => _SignupGymPageState();
}

class _SignupGymPageState extends State<SignupGymPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _profileImgUrlController = TextEditingController();
  Location _location = Location(Coordinates(long: 0.0, lat: 0.0));

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldContext = ScaffoldMessenger.of(context);
    final String locationText =
        AppLocalizations.of(context)!.signup_location_updated;

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
              const SizedBox(height: 30),
              FormContainerWidget(
                hintText: AppLocalizations.of(context)!.signup_gymname,
                controller: _usernameController,
                isPasswordField: false,
              ),
              const SizedBox(height: 10),
              FormContainerWidget(
                hintText: AppLocalizations.of(context)!.login_email,
                controller: _emailController,
                isPasswordField: false,
              ),
              const SizedBox(height: 10),
              FormContainerWidget(
                hintText: AppLocalizations.of(context)!.login_pass,
                controller: _passwordController,
                isPasswordField: true,
              ),
              const SizedBox(height: 10),
              FormContainerWidget(
                hintText: AppLocalizations.of(context)!.signup_profile_url,
                controller: _emailController,
                isPasswordField: false,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  _location = await Location.getCurrentLocation();
                  if (_location.coordinates.lat != 0 ||
                      _location.coordinates.long != 0) {
                    scaffoldContext.showSnackBar(SnackBar(
                      content: Text(locationText),
                      backgroundColor: Colors.green,
                    ));
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.signup_location,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupGymPaymentPage(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        location: _location,
                        profileImgUrl: _profileImgUrlController.text != ""
                            ? _profileImgUrlController.text
                            : "https://pbs.twimg.com/profile_images/1012734094797606920/tgH_dDPl_400x400.jpg",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: Text(AppLocalizations.of(context)!.next),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 10),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
