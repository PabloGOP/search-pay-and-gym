import 'package:test/test.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:spag/models/users/user.dart';

void main() {
  group('UserModel', () {
    late UserModel user;

    setUp(() {
      user = UserModel(
          id: ObjectId(), name: "name", email: "email", purchases: []);
    });

    test('UserModel.forInsert creates a new UserModel with a new ObjectId', () {
      final newUser = UserModel.forInsert(name: "name", email: "email");

      expect(newUser.id, isNotNull);
      expect(newUser.name, 'name');
      expect(newUser.email, 'email');
    });

    test('UserModel.fromJson creates a UserModel from JSON', () {
      final json = {
        "_id": ObjectId(),
        "name": 'name',
        "email": 'email',
        "purchases": [],
      };

      final gymFromJson = UserModel.fromJson(json);

      expect(gymFromJson.id, json["_id"]);
      expect(gymFromJson.name, 'name');
      expect(gymFromJson.email, 'email');
    });

    test('toJsonSpecific adds UserModel specific fields to JSON', () {
      Map<String, dynamic> generalJson = {
        "_id": user.id,
        "name": user.name,
        "email": user.email,
      };

      final userJson = user.toJsonSpecific(generalJson);

      expect(userJson['purchases'], []);
    });
  });
}
