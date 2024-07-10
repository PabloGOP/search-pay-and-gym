import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:spag/models/users/gym.dart';
import 'package:spag/presentation/widgets/page_structure_widget.dart';
import 'package:spag/providers/user_provider.dart';
import 'package:spag/validators/number_validator.dart';
import 'package:spag/validators/text_validator.dart';

import '../../../models/offer.dart';

class GymOfferAddPage extends StatefulWidget {
  const GymOfferAddPage({super.key});

  @override
  State<GymOfferAddPage> createState() => _GymOfferAddPageState();
}

class _GymOfferAddPageState extends State<GymOfferAddPage> {
  DateTime selectedDate = DateTime.now();

  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  TextEditingController sessionsController = TextEditingController(text: "");
  TextEditingController priceController = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    GymModel gym =
        Provider.of<UserProvider>(context, listen: false).user as GymModel;

    return CommonPageStructure(
      title: localizations.gym_offer_add,
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
            TextFormField(
              controller: sessionsController,
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              decoration: InputDecoration(
                hintText: localizations.offer_sessions,
              ),
              validator: (value) => NumberValidator.validate(
                  value, localizations.offer_sessions, localizations),
            ),
            TextFormField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: false),
              decoration: InputDecoration(
                hintText: localizations.offer_price,
              ),
              validator: (value) => NumberValidator.validate(
                  value, localizations.offer_price, localizations),
            ),
            TextFormField(
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
                      initialDate: selectedDate, //get today's date
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2099));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    selectedDate = pickedDate;
                    dateController.text = formattedDate;
                  }
                }),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () => _addOffer(gym),
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

  void _addOffer(GymModel gym) async {
    if (_formKey.currentState!.validate()) {
      OfferModel newOffer = OfferModel.forInsert(
        title: titleController.text,
        description: descriptionController.text,
        expirationDate: selectedDate,
        numSessions: int.parse(sessionsController.text),
        price: double.parse(priceController.text),
        gymId: gym.id,
        profileImgUrl: gym.profileImgUrl,
      );
      await newOffer.insert().then((_) {
        Navigator.pop(context);
      });
    }
  }
}
