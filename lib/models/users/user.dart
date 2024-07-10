// Clase para usuarios generales
import 'package:spag/models/purchase.dart';

import 'abstract_user.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:spag/services/mongo_user_service.dart';

class UserModel extends AbstractUser {
  List<ObjectId> purchases;

  UserModel({
    required ObjectId id,
    required String name,
    required String email,
    required this.purchases,
  }) : super(id: id, role: Role.user, email: email, name: name);

  factory UserModel.forInsert({
    required String name,
    required String email,
  }) {
    return UserModel(
      id: ObjectId(),
      name: name,
      email: email,
      purchases: [],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<ObjectId> typedList = [];
    for (var element in json["purchases"]) {
      typedList.add(element);
    }

    UserModel obj = UserModel(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      purchases: typedList,
    );
    return obj;
  }

  @override
  Map<String, dynamic> toJsonSpecific(Map<String, dynamic> generalJson) {
    generalJson.addAll({"purchases": purchases});
    return generalJson;
  }

  @override
  Future<void> insert() async {
    await UserService.insert(this);
  }

  Future<List<PurchaseModel>> getPurchases() async {
    List<PurchaseModel> result = [];
    for (ObjectId purchaseId in purchases) {
      PurchaseModel p = await PurchaseModel.fromId(purchaseId);
      result.add(p);
    }
    return result;
  }

  Future<void> addPurchase(ObjectId purchaseId) async {
    purchases.add(purchaseId);
    await UserService.update(this);
  }
}
