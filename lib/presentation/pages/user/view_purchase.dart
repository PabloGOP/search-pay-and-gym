import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spag/models/purchase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spag/models/location.dart';
import 'package:spag/models/users/gym.dart';
import 'package:spag/presentation/widgets/page_structure_widget.dart';
import 'dart:async';
import 'package:qr_flutter/qr_flutter.dart';

class ViewPurchasePage extends StatefulWidget {
  const ViewPurchasePage({super.key});

  @override
  State<ViewPurchasePage> createState() => _ViewPurchasePageState();
}

class _ViewPurchasePageState extends State<ViewPurchasePage> {
  int activeIndex = 0;
  final urlImages = [
    "https://as1.ftcdn.net/v2/jpg/05/96/09/50/1000_F_596095068_zoGfha6hGPmz5eb6QWLOLLfntd6tOEUB.jpg",
    "https://logomaker.designfreelogoonline.com/media/productdesigner/logo/resized/1199_gym_logo-05.png",
    "https://www.creativefabrica.com/wp-content/uploads/2020/02/10/Gym-Logo-Graphics-1-6.jpg",
    "https://i.pinimg.com/originals/b1/3e/4d/b13e4d969147d824af9080689c701576.jpg",
  ];

  bool _trainingUsed = false;
  final StreamController<int> _countdownController = StreamController<int>();

  @override
  void dispose() {
    _countdownController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final PurchaseModel purchase =
        ModalRoute.of(context)!.settings.arguments as PurchaseModel;

    const spaceBox = SizedBox(height: 10);

    return FutureBuilder<GymModel>(
      future: GymModel.fromId(purchase.offer.gymId),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  purchase.offer.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                spaceBox,
                Text(
                  "${localizations.purchase_remaining_detail}: ${purchase.remainingSessions}",
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
                        onPressed:
                            _trainingUsed || purchase.remainingSessions < 1
                                ? null
                                : () => _useTraining(purchase),
                        icon: const Icon(Icons.sports_mma),
                        label: Text(localizations.purchase_use),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      if (_trainingUsed) ...[
                        spaceBox,
                        QrImageView(
                          data:
                              '${purchase.id.toString()}${purchase.remainingSessions}',
                          version: QrVersions.auto,
                          size: 200,
                          gapless: false,
                        ),
                        StreamBuilder<int>(
                          stream: _countdownController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                  'Time remaining: ${snapshot.data} seconds');
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> openMap(Location location) async {
    double lat = location.coordinates.lat;
    double long = location.coordinates.long;
    Uri googleUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');

    if (!await launchUrl(googleUrl)) {
      throw Exception("Could not launch $googleUrl");
    }
  }

  void _useTraining(PurchaseModel purchase) {
    purchase.useSession();
    setState(() {
      _trainingUsed = true;
    });
    _startCountdown(6);
  }

  void _startCountdown(int seconds) {
    _countdownController.add(seconds);
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        _countdownController.add(seconds);
      } else {
        timer.cancel();
        _countdownController.add(0);
        setState(() {
          _trainingUsed = false;
        });
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/user',
          ModalRoute.withName('/Home'),
          arguments: {'initialIndex': 1}, // To the my offers view
        );
      }
    });
  }
}
