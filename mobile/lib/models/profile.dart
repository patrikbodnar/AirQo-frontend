import 'package:app/services/services.dart';
import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'enum_constants.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 20, adapterName: 'ProfileAdapter')
class Profile extends HiveObject with EquatableMixin {
  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Profile({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.userId,
    required this.emailAddress,
    required this.phoneNumber,
    required this.device,
    required this.preferences,
    required this.photoUrl,
    required this.utcOffset,
  });
  @HiveField(0)
  @JsonKey(defaultValue: '')
  String title = '';

  @HiveField(1)
  @JsonKey(defaultValue: '')
  String firstName = '';

  @HiveField(2)
  @JsonKey(defaultValue: '')
  String userId = '';

  @HiveField(3, defaultValue: '')
  @JsonKey(defaultValue: '')
  String lastName = '';

  @HiveField(4, defaultValue: '')
  @JsonKey(defaultValue: '')
  String emailAddress = '';

  @HiveField(5, defaultValue: '')
  @JsonKey(defaultValue: '')
  String phoneNumber = '';

  @HiveField(6, defaultValue: '')
  @JsonKey(defaultValue: '')
  String device = '';

  @HiveField(7, defaultValue: 0)
  @JsonKey(defaultValue: 0)
  int utcOffset = 0;

  @HiveField(8, defaultValue: '')
  @JsonKey(defaultValue: '')
  String photoUrl = '';

  @HiveField(9)
  @JsonKey(required: false)
  UserPreferences preferences =
      UserPreferences(notifications: false, aqShares: 0, location: false);

  String getProfileViewName() {
    if (firstName != '') {
      return firstName.trim();
    } else if (lastName != '') {
      return lastName.trim();
    } else {
      return 'Hello';
    }
  }

  static Future<Profile> getProfile() async {
    return Hive.box<Profile>(HiveBox.profile).get(HiveBox.profile) ??
        await _initialize();
  }

  Gender getGender() {
    if (title.toLowerCase().contains(TitleOptions.mr.value.toLowerCase())) {
      return Gender.male;
    } else if (title
        .toLowerCase()
        .contains(TitleOptions.ms.value.toLowerCase())) {
      return Gender.female;
    } else {
      return Gender.undefined;
    }
  }

  String getInitials() {
    var initials = '';
    if (firstName.isNotEmpty) {
      initials = firstName[0].toUpperCase();
    }

    if (lastName.isNotEmpty) {
      initials = '$initials${lastName[0].toUpperCase()}';
    }

    return initials.isEmpty ? 'A' : initials;
  }

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  static Future<void> syncProfile() async {
    final hasConnection = await hasNetworkConnection();
    if (hasConnection && CustomAuth.isLoggedIn()) {
      final profile = await CloudStore.getProfile();
      await profile.update();
    }
  }

  Future<void> logOut() async {
    await _initialize();
  }

  Future<void> deleteAccount() async {
    await _initialize();
  }

  Future<void> updateName(String fullName) async {
    firstName = Profile.getNames(fullName).first;
    lastName = Profile.getNames(fullName).last;
    await update();
  }

  Future<bool> update({
    bool logout = false,
    bool? enableNotification,
    bool? enableLocation,
  }) async {
    if (enableNotification != null) {
      preferences.notifications = enableNotification;
    }

    if (enableLocation != null) {
      preferences.location = enableLocation;
    }

    this
      ..device = logout ? '' : await CloudMessaging.getDeviceToken() ?? ''
      ..utcOffset = DateTime.now().getUtcOffset();

    final user = CustomAuth.getUser();
    if (user != null && !CustomAuth.isGuestUser()) {
      this
        ..userId = user.uid
        ..phoneNumber = user.phoneNumber ?? ''
        ..emailAddress = user.email ?? '';

      await Hive.box<Profile>(HiveBox.profile)
          .put(HiveBox.profile, this)
          .whenComplete(() => CloudStore.updateProfile(this));
    } else {
      await Hive.box<Profile>(HiveBox.profile).put(HiveBox.profile, this);
    }

    return true;
  }

  static List<String> getNames(String fullName) {
    final namesArray = fullName.split(' ');

    switch (namesArray.length) {
      case 0:
        return ['', ''];
      case 1:
        return [namesArray.first, ''];
      default:
        return [namesArray.first, namesArray[1]];
    }
  }

  static Future<Profile> initializeGuestProfile() async {
    final user = CustomAuth.getUser();
    final userId = user != null ? user.uid : const Uuid().v4();

    return Profile(
      title: '',
      firstName: '',
      lastName: '',
      userId: userId,
      emailAddress: '',
      phoneNumber: '',
      device: await CloudMessaging.getDeviceToken() ?? '',
      preferences: UserPreferences(
        notifications:
            await PermissionService.checkPermission(AppPermission.notification),
        location:
            await PermissionService.checkPermission(AppPermission.location),
        aqShares: 0,
      ),
      utcOffset: DateTime.now().getUtcOffset(),
      photoUrl: '',
    );
  }

  static Future<Profile> _initialize() async {
    final profile = Profile(
      title: '',
      firstName: '',
      lastName: '',
      userId: const Uuid().v4(),
      emailAddress: '',
      phoneNumber: '',
      device: await CloudMessaging.getDeviceToken() ?? '',
      preferences: UserPreferences(
        notifications:
            await PermissionService.checkPermission(AppPermission.notification),
        location:
            await PermissionService.checkPermission(AppPermission.location),
        aqShares: 0,
      ),
      utcOffset: DateTime.now().getUtcOffset(),
      photoUrl: '',
    );

    await profile.update();

    return profile;
  }

  @override
  List<Object?> get props => [
        title,
        firstName,
        userId,
        lastName,
        emailAddress,
        photoUrl,
        phoneNumber,
        utcOffset,
        device,
        preferences,
      ];
}

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 120, adapterName: 'UserPreferencesTypeAdapter')
class UserPreferences extends HiveObject with EquatableMixin {
  UserPreferences({
    required this.notifications,
    required this.location,
    required this.aqShares,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
  @HiveField(0, defaultValue: false)
  @JsonKey(defaultValue: false, required: false)
  bool notifications;

  @HiveField(1, defaultValue: false)
  @JsonKey(defaultValue: false, required: false)
  bool location;

  @HiveField(2, defaultValue: 0)
  @JsonKey(defaultValue: 0, required: false)
  int aqShares;

  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);

  static UserPreferences initialize() {
    return UserPreferences(
      notifications: false,
      location: false,
      aqShares: 0,
    );
  }

  @override
  List<Object?> get props => [
        aqShares,
        location,
        notifications,
      ];
}
