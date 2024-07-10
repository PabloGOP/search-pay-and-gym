import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:spag/models/users/gym.dart';
import 'package:spag/presentation/widgets/form_container_widget.dart';
import 'package:spag/presentation/widgets/page_structure_widget.dart';
import 'package:spag/providers/user_provider.dart';
import 'package:spag/models/location.dart';

class SignupGymPaymentPage extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  final Location location;
  final String profileImgUrl;

  const SignupGymPaymentPage({
    super.key,
    required this.username,
    required this.email,
    required this.password,
    required this.location,
    required this.profileImgUrl,
  });

  @override
  State<SignupGymPaymentPage> createState() => _SignupGymPaymentPageState();
}

class _SignupGymPaymentPageState extends State<SignupGymPaymentPage> {
  bool _isLoading = false;

  TextEditingController _legalnameController = TextEditingController();
  TextEditingController _ibanController = TextEditingController();

  @override
  void dispose() {
    _legalnameController.dispose();
    _ibanController.dispose();
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
              FormContainerWidget(
                hintText: AppLocalizations.of(context)!.signup_gym_legalname,
                controller: _legalnameController,
                isPasswordField: false,
              ),
              const SizedBox(height: 10),
              FormContainerWidget(
                hintText: AppLocalizations.of(context)!.signup_gym_iban,
                controller: _ibanController,
                isPasswordField: false,
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 10),
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

    String legalname = _legalnameController.text;
    String iban = _ibanController.text;

    GymModel user = GymModel.forInsert(
      name: widget.username,
      email: widget.email,
      location: widget.location,
      legalname: legalname,
      iban: iban,
      profileImgUrl: widget.profileImgUrl,
    );

    user.signUp(widget.password).then((value) {
      setState(() => _isLoading = false);
      if (user.isLogged()) {
        Provider.of<UserProvider>(context, listen: false).user = user;
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/gym',
          ModalRoute.withName("/Home"),
        );
      } else {
        print("Not logged in LOL");
      }
    });

    setState(() {
      _isLoading = false;
    });
  }
}
