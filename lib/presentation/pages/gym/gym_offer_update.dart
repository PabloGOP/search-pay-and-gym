import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spag/presentation/widgets/page_structure_widget.dart';
import 'package:spag/validators/text_validator.dart';
import '../../../models/offer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GymOfferUpdatePage extends StatefulWidget {
  const GymOfferUpdatePage({super.key});

  @override
  State<GymOfferUpdatePage> createState() => _GymOfferUpdatePageState();
}

class _GymOfferUpdatePageState extends State<GymOfferUpdatePage> {
  DateTime selectedDate = DateTime.now();

  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController dateController = TextEditingController(text: "");
  TextEditingController priceController = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final OfferModel offer =
        ModalRoute.of(context)!.settings.arguments as OfferModel;

    titleController.text = offer.title;
    descriptionController.text = offer.description;

    dateController.text = DateFormat('yyyy-MM-dd').format(offer.expirationDate);
    selectedDate = offer.expirationDate;
    priceController.text = offer.price.toString();

    return CommonPageStructure(
      title: localizations.gym_offer_edit,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              maxLength: 30,
              maxLines: 1,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: localizations.offer_title,
              ),
              validator: (value) => TextValidator.validate(
                  value, localizations.offer_title, localizations),
            ),
            TextFormField(
              controller: descriptionController,
              minLines: 1,
              maxLines: null,
              decoration: InputDecoration(
                hintText: localizations.offer_description,
              ),
            ),
            TextField(
                controller: dateController,
                decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_today), //icon of text field
                    labelText:
                        localizations.offer_expiration //label text of field
                    ),
                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    dateController.text = formattedDate;
                  }
                }),
            TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: false),
              decoration: InputDecoration(
                hintText: localizations.offer_price,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () => _updateOffer(offer),
              icon: const Icon(Icons.save),
              label: Text(localizations.offer_save),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateOffer(OfferModel offer) async {
    if (_formKey.currentState!.validate()) {
      await offer
          .update(
              title: titleController.text,
              description: descriptionController.text,
              expirationDate: selectedDate,
              price: double.parse(priceController.text))
          .then((_) {
        Navigator.pop(context);
      });
    }
  }
}
