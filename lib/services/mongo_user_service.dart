import 'package:mongo_dart/mongo_dart.dart';
import 'package:spag/env.dart';
import 'package:spag/models/users/abstract_user.dart';
import 'package:spag/models/users/gym.dart';
import '../models/users/user.dart';

class UserService {
  static var db, collection;

  static void connect({bool testing = false}) async {
    String strDb = testing ? TEST_DB : PROD_DB;
    String uri = CONNECTION_STRING_A + strDb + CONNECTION_STRING_B;
    db = await Db.create(uri);

    await db.open();
    collection = db.collection(USERS_COLLECTION_NAME);
  }

  static Future<void> insert(AbstractUser abstract) async {
    await collection.insertOne(abstract.toJson());
  }

  static Future<void> delete(AbstractUser abstract) async {
    await collection.remove(where.id(abstract.id));
  }

  static Future<void> update(AbstractUser abstract) async {
    await collection.update({"_id": abstract.id}, abstract.toJson());
  }

  static Future<AbstractUser> getByEmail(String email) async {
    var result = await collection.findOne(where.eq("email", email));
    AbstractUser? user;

    if (result["role"] == Role.gym.name) {
      user = GymModel.fromJson(result);
    } else {
      user = UserModel.fromJson(result);
    }

    return user;
  }

  static Future<GymModel> findOneGym(ObjectId id) async {
    var result = await collection.findOne(where.eq("_id", id));
    GymModel gym = GymModel.fromJson(result);
    return gym;
  }
}
