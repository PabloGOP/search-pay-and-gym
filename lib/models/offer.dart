import 'package:mongo_dart/mongo_dart.dart';
import 'package:spag/models/offer_filters.dart';
import 'package:spag/services/mongo_offer_service.dart';

class OfferModel {
  ObjectId id;
  String title;
  String description;
  DateTime expirationDate;
  double price;
  int numSessions;
  ObjectId gymId;
  String profileImgUrl;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.expirationDate,
    required this.price,
    required this.numSessions,
    required this.gymId,
    required this.profileImgUrl,
  });

  static OfferModel forInsert({
    required title,
    required description,
    required expirationDate,
    required price,
    required numSessions,
    required gymId,
    required profileImgUrl,
  }) {
    return OfferModel(
      id: ObjectId(),
      title: title,
      description: description,
      expirationDate: expirationDate,
      price: price,
      numSessions: numSessions,
      gymId: gymId,
      profileImgUrl: profileImgUrl,
    );
  }

  static Future<OfferModel> fromId(ObjectId id) async {
    return await OfferService.findOne(id);
  }

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        expirationDate: json["expirationDate"],
        price: json["price"],
        numSessions: json["num_sessions"],
        gymId: json["gym_id"],
        profileImgUrl: json["profile_img_url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "expirationDate": expirationDate,
        "price": price,
        "num_sessions": numSessions,
        "gym_id": gymId,
        "profile_img_url": profileImgUrl,
      };

  static Future<List<OfferModel>> getOffers(
    OfferFilter filter, {
    String sortBy = "",
    bool descending = true,
  }) async {
    return await OfferService.getOffers(
      filter,
      sortBy: sortBy,
      descending: descending,
    );
  }

  Future<void> insert() async {
    await OfferService.insert(this);
  }

  Future<void> update(
      {required String title,
      required String description,
      required DateTime expirationDate,
      required double price}) async {
    this.title = title;
    this.description = description;
    this.expirationDate = expirationDate;
    this.price = price;

    await OfferService.update(this);
  }

  Future<void> delete() async {
    await OfferService.delete(this);
  }
}
