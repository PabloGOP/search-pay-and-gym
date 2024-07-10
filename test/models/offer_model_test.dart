import 'package:test/test.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:spag/models/offer.dart';

void main() {
  group('OfferModel', () {
    late OfferModel offer;

    setUp(() {
      offer = OfferModel(
        id: ObjectId(),
        title: "title",
        description: "description",
        expirationDate: DateTime(2024),
        price: 10,
        numSessions: 1,
        gymId: ObjectId(),
        profileImgUrl: "example.png",
      );
    });

    test('OfferModel.forInsert creates a new OfferModel with a new ObjectId',
        () {
      final newoffer = OfferModel.forInsert(
        title: "title",
        description: "description",
        expirationDate: DateTime(2024),
        price: 10.5,
        numSessions: 1,
        gymId: ObjectId(),
        profileImgUrl: "example.png",
      );

      expect(newoffer.id, isNotNull);
      expect(newoffer.title, 'title');
      expect(newoffer.description, 'description');
      expect(newoffer.numSessions, 1);
    });

    test('OfferModel.fromJson creates a OfferModel from JSON', () {
      final json = {
        "_id": offer.id,
        "title": offer.title,
        "description": offer.description,
        "expirationDate": offer.expirationDate,
        "price": offer.price,
        "num_sessions": offer.numSessions,
        "gym_id": offer.gymId,
        "profile_img_url": offer.profileImgUrl,
      };

      final offerFromJson = OfferModel.fromJson(json);

      expect(offerFromJson.id, json["_id"]);
      expect(offerFromJson.title, json["title"]);
      expect(offerFromJson.description, json["description"]);
      expect(offerFromJson.expirationDate, json["expirationDate"]);
      expect(offerFromJson.price, json["price"]);
      expect(offerFromJson.numSessions, json["num_sessions"]);
      expect(offerFromJson.gymId, json["gym_id"]);
      expect(offerFromJson.profileImgUrl, json["profile_img_url"]);
    });

    test('toJsonSpecific adds OfferModel specific fields to JSON', () {
      final json = offer.toJson();
      expect(json["_id"], offer.id);
      expect(json["title"], offer.title);
      expect(json["description"], offer.description);
      expect(json["expirationDate"], offer.expirationDate);
      expect(json["price"], offer.price);
      expect(json["num_sessions"], offer.numSessions);
      expect(json["gym_id"], offer.gymId);
      expect(json["profile_img_url"], offer.profileImgUrl);
    });
  });
}
