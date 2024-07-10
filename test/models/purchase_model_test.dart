import 'package:spag/models/offer.dart';
import 'package:test/test.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:spag/models/purchase.dart';

void main() {
  group('PurchaseModel', () {
    late PurchaseModel purchase;

    setUp(() {
      purchase = PurchaseModel(
        id: ObjectId(),
        purchaseDate: DateTime(2024),
        price: 5.0,
        remainingSessions: 0,
        offer: OfferModel(
          id: ObjectId(),
          title: "title",
          description: "description",
          expirationDate: DateTime(2024),
          price: 10,
          numSessions: 1,
          gymId: ObjectId(),
          profileImgUrl: "example.png",
        ),
      );
    });

    test(
        'PurchaseModel.forInsert creates a new PurchaseModel with a new ObjectId',
        () {
      final newPurchase = PurchaseModel.forInsert(
        price: 5.0,
        remainingSessions: 0,
        offer: OfferModel(
          id: ObjectId(),
          title: "title",
          description: "description",
          expirationDate: DateTime(2024),
          price: 10.5,
          numSessions: 1,
          gymId: ObjectId(),
          profileImgUrl: "example.png",
        ),
      );

      expect(newPurchase.id, isNotNull);
      expect(newPurchase.price, 5.0);
      expect(newPurchase.remainingSessions, 0);
      expect(newPurchase.offer.title, 'title');
    });

    test('toJsonSpecific adds PurchaseModel specific fields to JSON', () {
      final json = purchase.toJson();
      expect(json["_id"], purchase.id);
      expect(json["purchase_date"], purchase.purchaseDate);
      expect(json["price"], purchase.price);
      expect(json["remaining_sessions"], purchase.remainingSessions);
    });
  });
}
