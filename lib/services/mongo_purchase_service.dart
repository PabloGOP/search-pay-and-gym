import 'package:mongo_dart/mongo_dart.dart';
import 'package:spag/models/purchase.dart';
import 'package:spag/env.dart';

class PurchaseService {
  static var db, collection;

  static void connect({bool testing = false}) async {
    String strDb = testing ? TEST_DB : PROD_DB;
    String uri = CONNECTION_STRING_A + strDb + CONNECTION_STRING_B;
    db = await Db.create(uri);

    await db.open();
    collection = db.collection(PURCHASES_COLLECTION_NAME);
  }

  static Future<void> insert(PurchaseModel purchase) async {
    await collection.insertOne(purchase.toJson());
  }

  static Future<void> update(PurchaseModel purchase) async {
    await collection.update({"_id": purchase.id}, purchase.toJson());
  }

  static Future<PurchaseModel> findOne(ObjectId id) async {
    var result = await collection.findOne({"_id": id});
    PurchaseModel purchase = await PurchaseModel.fromJson(result);
    return purchase;
  }
}
