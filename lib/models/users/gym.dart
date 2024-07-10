// Clase para usuarios de gimnasio
import 'abstract_user.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:spag/models/offer.dart';
import 'package:spag/models/offer_filters.dart';
import 'package:spag/services/mongo_user_service.dart';
import 'package:spag/services/mongo_offer_service.dart';
import '../location.dart';

class GymModel extends AbstractUser {
  Location location;
  String legalname;
  String iban;
  String profileImgUrl =
      "https://pbs.twimg.com/profile_images/1012734094797606920/tgH_dDPl_400x400.jpg";

  GymModel(
      {required ObjectId id,
      required String name,
      required String email,
      required this.location,
      required this.legalname,
      required this.iban,
      this.profileImgUrl =
          "https://pbs.twimg.com/profile_images/1012734094797606920/tgH_dDPl_400x400.jpg"})
      : super(id: id, role: Role.gym, email: email, name: name);

  factory GymModel.forInsert(
      {required String name,
      required String email,
      required Location location,
      required String legalname,
      required String iban,
      String profileImgUrl =
          "https://pbs.twimg.com/profile_images/1012734094797606920/tgH_dDPl_400x400.jpg"}) {
    return GymModel(
      id: ObjectId(),
      name: name,
      email: email,
      location: location,
      legalname: legalname,
      iban: iban,
    );
  }

  static Future<GymModel> fromId(ObjectId id) async {
    return await UserService.findOneGym(id);
  }

  factory GymModel.fromJson(Map<String, dynamic> json) {
    GymModel obj = GymModel(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      location: Location.fromDB(json["location"]),
      legalname: json["legalname"],
      iban: json["iban"],
      profileImgUrl: json["profile_img_url"],
    );
    return obj;
  }

  @override
  Map<String, dynamic> toJsonSpecific(Map<String, dynamic> generalJson) {
    generalJson.addAll({
      "location": location.toJson(),
      "legalname": legalname,
      "iban": iban,
      "profile_img_url": profileImgUrl,
    });

    return generalJson;
  }

  Future<List<OfferModel>> getOffers() async {
    OfferFilter filter = OfferFilter(gymId: id);
    return await OfferService.getOffers(filter);
  }

  @override
  Future<void> insert() async {
    await UserService.insert(this);
  }
}
