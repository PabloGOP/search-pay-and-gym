import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Internazionalization
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Pages
import 'presentation/pages/gym/gym_offer_add.dart';
import 'presentation/pages/gym/gym_offer_update.dart';
import 'presentation/pages/gym/gym_home_page.dart';
import 'presentation/pages/user/user_home_page.dart';
import 'presentation/pages/user/view_offer.dart';
import 'presentation/pages/user/view_purchase.dart';
import 'presentation/pages/filters_selection_page.dart';
import 'presentation/pages/splash.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/auth/signup_page.dart';
import 'presentation/pages/auth/signup_gym_page.dart';
import 'presentation/pages/auth/signup_user_page.dart';

// Theme
import 'package:spag/presentation/theme/themes.dart';
import 'providers/theme_provider.dart';

/*
primary: #ff9f15
secondary: #FFDCBB
tertiary: #abece4
error: #fb7991
*/

// Mongo Services
import 'services/mongo_offer_service.dart';
import 'services/mongo_user_service.dart';
import 'package:spag/services/mongo_purchase_service.dart';

import 'package:spag/providers/user_provider.dart';

void main() async {
  // Firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  OfferService.connect();
  UserService.connect();
  PurchaseService.connect();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Pay And Gym',
      initialRoute: '/splash',
      routes: {
        '/gym': (context) => const GymHomePage(),
        '/gym/addOffer': (context) => const GymOfferAddPage(),
        '/gym/updateOffer': (context) => const GymOfferUpdatePage(),
        '/user': (context) => const UserHomePage(),
        '/user/viewOffer': (context) => const ViewOfferPage(),
        '/user/viewPurchase': (context) => const ViewPurchasePage(),
        '/filterOffers': (context) => const FiltersSelectionPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/signupGym': (context) => const SignupGymPage(),
        '/signupUser': (context) => const SignupUserPage(),
        '/splash': (context) => const SplashScreen(),
      },
      themeMode: Provider.of<ThemeProvider>(context).mode,
      theme: lightMode,
      darkTheme: darkMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
