import 'package:flutter/material.dart';
import 'package:spag/models/offer.dart';
import 'package:spag/models/offer_filters.dart';

class AllOffersView extends StatefulWidget {
  const AllOffersView({
    super.key,
  });

  @override
  State<AllOffersView> createState() => _AllOffersViewState();
}

class _AllOffersViewState extends State<AllOffersView> {
  // Elements order:
  String sortBy = "title";
  bool descending = false;

  // Filtros:
  bool isFilerApplied = false;
  OfferFilter filters = OfferFilter();

  // Bottom bar:
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const double iconSize = 24;
    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: sortBy == "title"
                        ? Theme.of(context).colorScheme.tertiaryContainer
                        : null,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Row(
                      children: [
                        RotatedBox(
                          quarterTurns: descending ? 2 : 0,
                          child: const Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            size: iconSize,
                          ),
                        ),
                        const Icon(Icons.abc_rounded, size: iconSize),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        if (sortBy == "title") {
                          descending = !descending;
                        } else {
                          sortBy = "title";
                          descending = false;
                        }
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: sortBy == "price"
                        ? Theme.of(context).colorScheme.tertiaryContainer
                        : null,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Row(
                      children: [
                        RotatedBox(
                          quarterTurns: descending ? 2 : 0,
                          child: const Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            size: iconSize,
                          ),
                        ),
                        const Icon(Icons.euro_rounded, size: iconSize),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        if (sortBy == "price") {
                          descending = !descending;
                        } else {
                          sortBy = "price";
                          descending = false;
                        }
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                      isFilerApplied ? Icons.filter_alt_off : Icons.filter_alt,
                      size: iconSize),
                  onPressed: () async {
                    if (!isFilerApplied) {
                      final result = await Navigator.pushNamed(
                          context, '/filterOffers',
                          arguments: filters);
                      setState(() {
                        isFilerApplied = true;
                        filters =
                            result != null ? result as OfferFilter : filters;
                      });
                    } else {
                      setState(() {
                        isFilerApplied = false;
                        filters = OfferFilter();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: OfferModel.getOffers(
                filters,
                sortBy: sortBy,
                descending: descending,
              ),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      OfferModel offer = (snapshot.data?[index])!;
                      return ListTile(
                        leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(offer.profileImgUrl)),
                        title: Text(offer.title),
                        subtitle: Text(
                          offer.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // dense: true,
                        trailing: Text(
                          "${offer.price} €",
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () async {
                          await Navigator.pushNamed(context, '/user/viewOffer',
                              arguments: offer);
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
              })),
        ),
      ],
    );
  }
}
