import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spag/models/purchase.dart';
import 'package:spag/models/users/user.dart';
import 'package:spag/providers/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyOffersView extends StatefulWidget {
  const MyOffersView({
    super.key,
  });

  @override
  State<MyOffersView> createState() => _MyOffersViewState();
}

class _MyOffersViewState extends State<MyOffersView> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    UserModel user =
        Provider.of<UserProvider>(context, listen: false).user as UserModel;

    return FutureBuilder(
        future: user.getPurchases(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                PurchaseModel purchase = (snapshot.data?[index])!;
                return ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(purchase.offer.profileImgUrl),
                  ),
                  title: Text(purchase.offer.title),
                  subtitle: Text(
                    DateFormat('EEE, M/d/y').format(purchase.purchaseDate),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // dense: true,
                  trailing: Text(
                    "${purchase.remainingSessions} ${localizations.purchase_remaining}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () async {
                    await Navigator.pushNamed(context, '/user/viewPurchase',
                        arguments: purchase);
                    setState(() {});
                  },
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}
