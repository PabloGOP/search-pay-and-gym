import 'package:mongo_dart/mongo_dart.dart';
import 'package:spag/models/offer_filters.dart';
import '../models/offer.dart';
import 'package:spag/env.dart';

class OfferService {
  static var db, collection;

  static void connect({bool testing = false}) async {
    String strDb = testing ? TEST_DB : PROD_DB;
    String uri = CONNECTION_STRING_A + strDb + CONNECTION_STRING_B;
    db = await Db.create(uri);

    await db.open();
    collection = db.collection(OFFERS_COLLECTION_NAME);
  }

  static Future<List<OfferModel>> getOffers(
    OfferFilter filter, {
    String sortBy = "title",
    bool descending = true,
  }) async {
    List<OfferModel> offers = [];
    List result;

    SelectorBuilder query = SelectorBuilder();
    if (filter.id != null) {
      query.eq("_id", filter.id);
    }
    if (filter.gymId != null) {
      query.eq("gym_id", filter.gymId);
    }
    if (filter.title != null) {
      query.match("title", filter.title!, caseInsensitive: false);
    }
    if (filter.priceValues != null) {
      query.gte("price", filter.priceValues!.start);
      query.lte("price", filter.priceValues!.end);
    }
    query.sortBy(sortBy, descending: descending);

    result = await collection.find(query).toList();

    for (var element in result) {
      offers.add(OfferModel.fromJson(element));
    }

    return offers;
  }

  static Future<void> insert(OfferModel offer) async {
    await collection.insertOne(offer.toJson());
  }

  static Future<void> update(OfferModel offer) async {
    await collection.update({"_id": offer.id}, offer.toJson());
  }

  static Future<void> delete(OfferModel offer) async {
    await collection.remove(where.id(offer.id));
  }

  static Future<OfferModel> findOne(ObjectId id) async {
    var result = await collection.findOne({"_id": id});
    OfferModel gym = OfferModel.fromJson(result);
    return gym;
  }
}
