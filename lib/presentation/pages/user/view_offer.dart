import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spag/models/purchase.dart';
import 'package:spag/models/users/user.dart';
import 'package:spag/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:spag/models/location.dart';
import 'package:spag/models/offer.dart';
import 'package:spag/models/users/gym.dart';
import 'package:spag/presentation/widgets/page_structure_widget.dart';

class ViewOfferPage extends StatefulWidget {
  const ViewOfferPage({super.key});

  @override
  State<ViewOfferPage> createState() => _ViewOfferPageState();
}

class _ViewOfferPageState extends State<ViewOfferPage> {
  int activeIndex = 0;
  final urlImages = [
    "https://as1.ftcdn.net/v2/jpg/05/96/09/50/1000_F_596095068_zoGfha6hGPmz5eb6QWLOLLfntd6tOEUB.jpg",
    "https://logomaker.designfreelogoonline.com/media/productdesigner/logo/resized/1199_gym_logo-05.png",
    "https://www.creativefabrica.com/wp-content/uploads/2020/02/10/Gym-Logo-Graphics-1-6.jpg",
    "https://i.pinimg.com/originals/b1/3e/4d/b13e4d969147d824af9080689c701576.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final OfferModel offer =
        ModalRoute.of(context)!.settings.arguments as OfferModel;

    UserModel user =
        Provider.of<UserProvider>(context, listen: false).user as UserModel;

    const spaceBox = SizedBox(height: 10);

    return FutureBuilder<GymModel>(
      future: GymModel.fromId(offer.gymId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final gym = snapshot.data!;
          return CommonPageStructure(
            title: gym.name.toUpperCase(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                spaceBox,
                //expiration date -> Date, no datetime
                Text(
                  '${localizations.offer_expiration}: ${DateFormat('EEE, M/d/y').format(offer.expirationDate)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                spaceBox,
                Text(
                  offer.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                spaceBox,
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          openMap(gym.location);
                        },
                        child: Text(
                          localizations.offer_go,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      spaceBox,
                      ElevatedButton.icon(
                        onPressed: () => _buyOffer(user, offer),
                        icon: const Icon(Icons.euro),
                        label: Text(offer.price.toStringAsFixed(2)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                spaceBox,
                StatefulBuilder(
                  builder: (context, setState) => Column(children: [
                    CarouselSlider.builder(
                      itemCount: urlImages.length,
                      itemBuilder: (context, index, realIndex) {
                        final url = urlImages[index];
                        return buildImage(url, index);
                      },
                      options: CarouselOptions(
                        height: 400,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                      ),
                    ),
                    spaceBox,
                    buildIndicator()
                  ]),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildIndicator() => Center(
        child: AnimatedSmoothIndicator(
          effect: ExpandingDotsEffect(
              dotWidth: 15,
              activeDotColor: Theme.of(context).colorScheme.inversePrimary),
          activeIndex: activeIndex,
          count: urlImages.length,
        ),
      );

  Widget buildImage(String urlImage, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
        // handle case of error obtaining the image:
        errorBuilder: (context, error, stackTrace) {
          return const Image(
            image: AssetImage("assets/images/hp_logo.png"),
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Future<void> openMap(Location location) async {
    double lat = location.coordinates.lat;
    double long = location.coordinates.long;
    //REVIEW - As in spag\android\app\src\main\AndroidManifest.xml, it may be necessary to update sth for iOS
    Uri googleUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');

    if (!await launchUrl(googleUrl)) {
      throw Exception("Could not launch $googleUrl");
    }
    // if (await canLaunch(googleUrl)) {
    //   await launch(googleUrl);
    // } else {
    //   throw 'Could not open the map.';
    // }
  }

  void _buyOffer(UserModel user, OfferModel offer) async {
    PurchaseModel purchase = PurchaseModel.forInsert(
        price: offer.price, remainingSessions: offer.numSessions, offer: offer);

    purchase.insert().then((value) {
      user.addPurchase(purchase.id);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/user',
        ModalRoute.withName('/Home'),
        arguments: {'initialIndex': 1}, // To the my offers view
      );
    });
  }
}
