import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart' as httpparser;
import 'package:gohealth/data/model/exercise.dart';
import 'package:gohealth/data/model/history_bmi.dart';
import 'package:gohealth/data/model/response.dart' as rp;
import 'package:gohealth/data/model/response_update_pp.dart';
import 'package:gohealth/data/model/user_profile.dart';
import 'package:gohealth/data/service/local_service.dart';

abstract class BaseService {
  Future<List<Exercise>> getExercise();
  Future<rp.Response> login(String email, String password);
  Future<rp.Response> register(
      String email, String password, UserProfile profil);
  Future<ResponseUpdatePp> updatePhotoProfile(File image);
  Future<List<HistoryBmi>> getHistoryBmi();
  Future<rp.Response> updateBmi(double height, double weight);
  Future<rp.Response> updateProfile(String email, String password, String nama);
  Future<UserProfile> getProfile();
  static const exerciseEndpoint = "/exercises";
  static const loginEndpoint = "/auth/login";
  static const registerEndpoint = "/auth/register";
  static const profileEndpoint = "/profile";
  static const bmiEndpoint = "/bmi";
}

class NetworkService extends BaseService {
  NetworkService._internal();
  static final _singleton = NetworkService._internal();
  factory NetworkService() => _singleton;
  static const String BASEURL = "http://192.168.43.2";

  final Dio _dio = Dio(BaseOptions(
    baseUrl: BASEURL,
  ));
  final LocalService _localService = LocalService();

  @override
  Future<List<Exercise>> getExercise() async {
    List<Exercise> exercises = [];
    var response = await _dio.get<List>(BaseService.exerciseEndpoint);
    if (response.statusCode == 200) {
      print(response.data);
      (response.data ?? [])
          .map<Exercise>((e) => Exercise.fromJson(e))
          .forEach((element) {
        exercises.add(element);
      });
    }
    return exercises;
  }

  @override
  Future<List<HistoryBmi>> getHistoryBmi() async {
    List<HistoryBmi> history = [];
    int id = (await _localService.getLoginDetails())["idUser"];
    var response =
        await _dio.get<List>(BaseService.bmiEndpoint + "/$id/history");
    if (response.statusCode == 200) {
      (response.data ?? [])
          .map<HistoryBmi>((e) => HistoryBmi.fromJson(e))
          .forEach((element) {
        history.add(element);
      });
    }
    return history;
  }

  @override
  Future<UserProfile> getProfile() async {
    int id = (await _localService.getLoginDetails())["idUser"];
    var response = await _dio
        .get<Map<String, dynamic>>(BaseService.profileEndpoint + "/$id/detail");
    if (response.statusCode == 200) {
      return UserProfile.fromJson(
          response.data ?? {"message": "internal error"});
    }
    return UserProfile();
  }

  @override
  Future<rp.Response> login(String email, String password) async {
    var response = await _dio.post<Map<String, dynamic>>(
      BaseService.loginEndpoint,
      data: FormData.fromMap({
        "email": email,
        "password": password,
      }),
    );
    if (response.statusCode == 200) {
      return rp.Response.fromJson(
          response.data ?? {"message": "internal error"});
    }
    return rp.Response(message: "internal error");
  }

  @override
  Future<rp.Response> register(
    String email,
    String password,
    UserProfile profile,
  ) async {
    var data = profile.toJson();
    data.removeWhere((key, value) => value == null);
    data.addAll({
      "email": email,
      "password": password,
    });
    var formData = FormData.fromMap(data);
    debugPrint(data.toString());
    var response = await _dio.post<Map<String, dynamic>>(
        BaseService.registerEndpoint,
        data: formData);
    if (response.statusCode == 200) {
      return rp.Response.fromJson(
          response.data ?? {"message": "internal error"});
    }
    return rp.Response(message: "internal error");
  }

  @override
  Future<rp.Response> updateBmi(double height, double weight) async {
    Map<String, dynamic> data = {
      'height': height,
      'weight': weight,
    };
    int id = (await _localService.getLoginDetails())["idUser"];

    var response = await _dio.post<Map<String, dynamic>>(
        BaseService.bmiEndpoint + "/$id/update",
        data: FormData.fromMap(data));
    if (response.statusCode == 200) {
      return rp.Response.fromJson(
          response.data ?? {"message": "internal error"});
    }
    return rp.Response(
      message: "cannot connect to server",
      result: false,
    );
  }

  @override
  Future<ResponseUpdatePp> updatePhotoProfile(File image) async {
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(image.path,
          filename: image.path.split('/').last,
          contentType: httpparser.MediaType.parse("image/jpeg")),
    });
    int id = (await _localService.getLoginDetails())["idUser"];
    var response = await _dio.post<Map<String, dynamic>>(
        BaseService.profileEndpoint + "/$id/photo/update",
        data: formData);
    if (response.statusCode == 200) {
      return ResponseUpdatePp.fromJson(
          response.data ?? {"message": "internal error"});
    }
    return ResponseUpdatePp(message: "internal error");
  }

  @override
  Future<rp.Response> updateProfile(
      String email, String password, String name) async {
    int id = (await _localService.getLoginDetails())["idUser"];

    var map = {
      'email': email,
      'password': password,
      'name': name,
    };
    var response = await _dio.post(
      BaseService.profileEndpoint + "/$id/update",
      data: FormData.fromMap(map),
    );
    if (response.statusCode == 200) {
      return rp.Response.fromJson(response.data);
    }

    return rp.Response(message: "internal error");
  }
}
