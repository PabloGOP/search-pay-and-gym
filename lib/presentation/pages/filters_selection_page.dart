import 'package:flutter/material.dart';
import 'package:spag/models/offer_filters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spag/presentation/widgets/page_structure_widget.dart';

class FiltersSelectionPage extends StatefulWidget {
  const FiltersSelectionPage({super.key});

  @override
  State<FiltersSelectionPage> createState() => _FiltersSelectionPageState();
}

class _FiltersSelectionPageState extends State<FiltersSelectionPage> {
  TextEditingController titleController = TextEditingController(text: "");

  RangeValues priceValues = const RangeValues(00, 100);
  double maxPrice = 100;

  @override
  Widget build(BuildContext context) {
    OfferFilter filters =
        ModalRoute.of(context)!.settings.arguments as OfferFilter;

    if (filters.title != null) {
      titleController.text = filters.title!;
    }
    if (filters.priceValues != null) {
      priceValues = filters.priceValues!;
    }

    return CommonPageStructure(
      title: AppLocalizations.of(context)!.offer_filter,
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.offer_title,
            ),
          ),
          const SizedBox(height: 30),
          Text('${AppLocalizations.of(context)!.offer_price}:'),
          RangeSlider(
            values: priceValues,
            max: maxPrice,
            labels: RangeLabels(
              priceValues.start.round().toString(),
              priceValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                priceValues = values;
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                filters.title =
                    titleController.text != "" ? titleController.text : null;
                filters.priceValues = priceValues;
                Navigator.pop(context, filters);
              },
              child: Text(AppLocalizations.of(context)!.apply)),
        ],
      ),
    );
  }
}
