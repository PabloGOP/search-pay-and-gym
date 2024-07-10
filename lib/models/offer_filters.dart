import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

// No se pueden hacer muchos más filtros:
// https://stackoverflow.com/questions/46568142/google-firestore-query-on-substring-of-a-property-value-text-search/52715590#52715590
// Ahora con Mongo sí hehehe
class OfferFilter {
  ObjectId? id;
  String? title;
  RangeValues? priceValues;
  ObjectId? gymId;

  OfferFilter({
    this.id,
    this.title,
    this.priceValues,
    this.gymId,
  });
}
