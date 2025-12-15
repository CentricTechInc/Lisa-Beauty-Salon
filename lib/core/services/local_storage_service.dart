// import 'dart:convert';
//
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:lifestyle_in_islam_app/data/dto/auth_dto.dart';
// import 'package:lifestyle_in_islam_app/data/dto/prayer_time_dto.dart';
// import 'package:lifestyle_in_islam_app/data/dto/quran_dto.dart';
// import 'package:lifestyle_in_islam_app/domain/entities/auth_model.dart';
//
// /// Keys for secure storage
// enum Key {
//   user,
//   fcmToken,
//   isSocialLogin,
//   appVersion,
//   lastReadQuranChapter,
//   alarmAudioUrl,
//   activePrayerAlarms,
//   saveQuranQuickAccessSettings,
// }
//
// class LocalStorageService {
//   static const _storage = FlutterSecureStorage();
//   static final LocalStorageService _singleton = LocalStorageService._internal();
//
//   LocalStorageService._internal();
//
//   static LocalStorageService get instance => _singleton;
//
//   /// -------------------- Init with version check --------------------
//   Future<void> init(String currentAppVersion) async {
//     final savedVersion = await _storage.read(key: Key.appVersion.name);
//
//     if (savedVersion == null) {
//       // 🔹 Fresh install OR reinstall
//       await _storage.deleteAll(); // wipe everything
//       await _storage.write(key: Key.appVersion.name, value: currentAppVersion);
//     } else if (savedVersion != currentAppVersion) {
//       // 🔹 App updated
//       await _storage.write(key: Key.appVersion.name, value: currentAppVersion);
//     }
//   }
//
//   /// -------------------- User --------------------
//   Future<UserDto?> get user async {
//     final rawJson = await _storage.read(key: Key.user.name);
//     if (rawJson == null) return null;
//     return UserDto.fromRawJson(rawJson);
//   }
//
//   Future<void> setUser(UserModel? value) async {
//     if (value != null) {
//       // map to UserDto for serialization
//       final dto = (value is UserDto) ? value : UserDto(
//         id: value.id,
//         name: value.name,
//         email: value.email,
//         phone: value.phone,
//         dob: value.dob,
//         password: value.password,
//         role: value.role,
//         picture: value.picture,
//         gender: value.gender,
//         isEmailVerified: value.isEmailVerified,
//         token: value.token,
//       );
//       await _storage.write(key: Key.user.name, value: dto.toRawJson());
//     } else {
//       await _storage.delete(key: Key.user.name);
//     }
//   }
//
//   /// -------------------- FCM Token --------------------
//   Future<String?> get fcmToken async => await _storage.read(key: Key.fcmToken.name);
//
//   Future<void> setFcmToken(String? token) async {
//     if (token != null) {
//       await _storage.write(key: Key.fcmToken.name, value: token);
//     } else {
//       await _storage.delete(key: Key.fcmToken.name);
//     }
//   }
//
//   /// -------------------- Social Login --------------------
//   Future<bool> get isSocialLogin async {
//     final val = await _storage.read(key: Key.isSocialLogin.name);
//     return val == "true";
//   }
//
//   Future<void> setSocialLogin(String value) async {
//     await _storage.write(key: Key.isSocialLogin.name, value: value);
//   }
//
//   // -------------------- Quran Data --------------------
//   Future<void> setLastReadChapter(
//       QuranChapterDto? quranChapter
//       ) async {
//     await _storage.write(
//         key: Key.lastReadQuranChapter.name,
//         value: quranChapter?.toRawJson()
//     );
//   }
//
//   Future<QuranChapterDto?> getLastReadChapter() async {
//     final data = await _storage.read(key: Key.lastReadQuranChapter.name);
//     return data == null ? null : QuranChapterDto.fromJson(jsonDecode(data));
//   }
//
//   Future<void> saveQuickAccessSettings(QuranSettingsDto settings) async {
//     await _storage.write(
//         key: Key.saveQuranQuickAccessSettings.name,
//         value: settings.toRawJson()
//     );
//   }
//
//   Future<QuranSettingsDto?> getQuickAccessSettings() async {
//     final data = await _storage.read(key: Key.saveQuranQuickAccessSettings.name);
//     return data == null ? null : QuranSettingsDto.fromJson(jsonDecode(data));
//   }
//
//   // -------------------- Prayer Alarms --------------------
//   Future<void> setAlarmAudio(
//       String path
//       ) async {
//     await _storage.write(
//         key: Key.alarmAudioUrl.name,
//         value: path
//     );
//   }
//
//   Future<String?> getAlarmAudio() async {
//     final data = await _storage.read(key: Key.alarmAudioUrl.name);
//     return data;
//   }
//
//   Future<void> setActiveAlarm(PrayerAlarmInfoDto alarm) async {
//     final existingJson = await _storage.read(key: Key.activePrayerAlarms.name);
//     List<Map<String, dynamic>> alarms = [];
//
//     if (existingJson != null) {
//       alarms = List<Map<String, dynamic>>.from(json.decode(existingJson));
//       alarms.removeWhere((a) => a['prayerName'] == alarm.prayerName);
//     }
//
//     alarms.add(alarm.toJson());
//     await _storage.write(key: Key.activePrayerAlarms.name, value: json.encode(alarms));
//   }
//
//   Future<void> removeActiveAlarm(String prayerName) async {
//     final existingJson = await _storage.read(
//         key: Key.activePrayerAlarms.name
//     );
//     if (existingJson == null) return;
//
//     final alarms = List<Map<String, dynamic>>.from(json.decode(existingJson));
//     alarms.removeWhere((a) => a['prayerName'] == prayerName);
//
//     await _storage.write(
//         key: Key.activePrayerAlarms.name,
//         value: json.encode(alarms)
//     );
//   }
//
//   /// -------------------- Logout --------------------
//   Future<void> logoutUser() async {
//     await _storage.delete(key: Key.user.name);
//     await _storage.delete(key: Key.fcmToken.name);
//     await _storage.delete(key: Key.isSocialLogin.name);
//     await _storage.delete(key: Key.lastReadQuranChapter.name);
//     await _storage.delete(key: Key.activePrayerAlarms.name);
//   }
// }
