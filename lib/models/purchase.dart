import 'package:mongo_dart/mongo_dart.dart';
import 'package:spag/models/offer.dart';
import 'package:spag/services/mongo_purchase_service.dart';

class PurchaseModel {
  ObjectId id;
  DateTime purchaseDate;
  double price;
  int remainingSessions;
  OfferModel offer;

  PurchaseModel({
    required this.id,
    required this.purchaseDate,
    required this.price,
    required this.remainingSessions,
    required this.offer,
  });

  static PurchaseModel forInsert({
    required price,
    required remainingSessions,
    required offer,
  }) {
    return PurchaseModel(
      id: ObjectId(),
      purchaseDate: DateTime.now(),
      price: price,
      remainingSessions: remainingSessions,
      offer: offer,
    );
  }

  static Future<PurchaseModel> fromId(ObjectId id) async {
    return await PurchaseService.findOne(id);
  }

  static Future<PurchaseModel> fromJson(Map<String, dynamic> json) async =>
      PurchaseModel(
        id: json["_id"],
        purchaseDate: json["purchase_date"],
        price: json["price"],
        remainingSessions: json["remaining_sessions"],
        offer: await OfferModel.fromId(json["offer_id"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "purchase_date": purchaseDate,
        "price": price,
        "remaining_sessions": remainingSessions,
        "offer_id": offer.id,
      };

  static Future<List<PurchaseModel>> getPurchases(
    List<ObjectId> purchases,
  ) async {
    List<PurchaseModel> result = [];
    for (ObjectId id in purchases) {
      result.add(await PurchaseModel.fromId(id));
    }
    return result;
  }

  Future<void> insert() async {
    await PurchaseService.insert(this);
  }

  Future<void> useSession() async {
    remainingSessions--;
    await PurchaseService.update(this);
  }
}
