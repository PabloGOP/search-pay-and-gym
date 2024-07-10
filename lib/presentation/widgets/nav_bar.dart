import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:spag/models/users/abstract_user.dart';
import 'package:spag/providers/theme_provider.dart';
import 'package:spag/providers/user_provider.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final bool withBorder;
  const NavBar({super.key, this.withBorder = true});

  @override
  Widget build(BuildContext context) {
    bool hasUser = Provider.of<UserProvider>(context).hasUser;
    ThemeMode nextTheme = Theme.of(context).brightness == Brightness.light
        ? ThemeMode.dark
        : ThemeMode.light;
    return AppBar(
      title: Text(AppLocalizations.of(context)!.spag),
      centerTitle: true,
      titleTextStyle: Theme.of(context).textTheme.displayLarge,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 0,
      shape: withBorder
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            )
          : null,
      actions: [
        IconButton(
          icon: nextTheme == ThemeMode.dark
              ? const Icon(Icons.dark_mode)
              : const Icon(Icons.light_mode),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).mode = nextTheme;
          },
        ),
        if (hasUser)
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _signOut(BuildContext context) {
    AbstractUser? user =
        Provider.of<UserProvider>(context, listen: false).user!;
    user.signOut();
    Provider.of<UserProvider>(context, listen: false).signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      ModalRoute.withName("/Home"),
    );
  }
}
