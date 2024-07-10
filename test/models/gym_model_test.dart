import 'package:test/test.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:spag/models/users/gym.dart';
import 'package:spag/services/mongo_user_service.dart';
import 'package:spag/services/mongo_offer_service.dart';
import 'package:spag/models/location.dart';
import 'package:mockito/mockito.dart';

class MockUserService extends Mock implements UserService {}

class MockOfferService extends Mock implements OfferService {}

void main() {
  group('GymModel', () {
    late Location location;
    late GymModel gym;

    setUp(() {
      location = Location(Coordinates(long: 0.0, lat: 0.0));
      gym = GymModel(
        id: ObjectId(),
        name: 'Test Gym',
        email: 'test@gym.com',
        location: location,
        legalname: 'Test Legal Name',
        iban: 'Test IBAN',
      );
    });

    test('GymModel.forInsert creates a new GymModel with a new ObjectId', () {
      final newGym = GymModel.forInsert(
        name: 'New Gym',
        email: 'new@gym.com',
        location: location,
        legalname: 'New Legal Name',
        iban: 'New IBAN',
      );

      expect(newGym.id, isNotNull);
      expect(newGym.name, 'New Gym');
      expect(newGym.email, 'new@gym.com');
      expect(newGym.location, location);
      expect(newGym.legalname, 'New Legal Name');
      expect(newGym.iban, 'New IBAN');
      expect(newGym.profileImgUrl, isNotNull);
    });

    test('GymModel.fromJson creates a GymModel from JSON', () {
      final json = {
        "_id": ObjectId(),
        "name": 'Gym From JSON',
        "email": 'json@gym.com',
        "location": location.toJson(),
        "legalname": 'JSON Legal Name',
        "iban": 'JSON IBAN',
        "profile_img_url": 'https://example.com/profile.jpg',
      };

      final gymFromJson = GymModel.fromJson(json);

      expect(gymFromJson.id, json["_id"]);
      expect(gymFromJson.name, 'Gym From JSON');
      expect(gymFromJson.email, 'json@gym.com');
      expect(gymFromJson.location.coordinates.long, location.coordinates.long);
      expect(gymFromJson.location.coordinates.lat, location.coordinates.lat);
      expect(gymFromJson.legalname, 'JSON Legal Name');
      expect(gymFromJson.iban, 'JSON IBAN');
      expect(gymFromJson.profileImgUrl, 'https://example.com/profile.jpg');
    });

    test('toJsonSpecific adds GymModel specific fields to JSON', () {
      Map<String, dynamic> generalJson = {
        "_id": gym.id,
        "name": gym.name,
        "email": gym.email,
      };

      final gymJson = gym.toJsonSpecific(generalJson);

      expect(gymJson['location'], location.toJson());
      expect(gymJson['legalname'], 'Test Legal Name');
      expect(gymJson['iban'], 'Test IBAN');
      expect(gymJson['profile_img_url'], gym.profileImgUrl);
    });
  });
}
