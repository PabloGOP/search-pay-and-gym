import 'package:flutter/material.dart';
import 'package:spag/presentation/pages/user/views/all_offers.dart';
import 'package:spag/presentation/pages/user/views/my_offers.dart';
import 'package:spag/presentation/widgets/nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserHomePage extends StatefulWidget {
  final int initialIndex;

  const UserHomePage({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  // Bottom bar:
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null && args.containsKey('initialIndex')) {
        setState(() {
          selectedIndex = args['initialIndex'];
        });
      } else {
        selectedIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const views = [AllOffersView(), MyOffersView()];
    return Scaffold(
      appBar: const NavBar(withBorder: false),
      body: views[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore),
            label: AppLocalizations.of(context)!.user_label_general,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.wallet),
            activeIcon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.user_label_owned,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        ],
      ),
    );
  }
}
