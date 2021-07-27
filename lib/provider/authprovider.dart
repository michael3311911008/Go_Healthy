import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gohealth/data/model/response.dart';
import 'package:gohealth/data/model/response_update_pp.dart';
import 'package:gohealth/data/model/user_profile.dart';
import 'package:gohealth/data/service/local_service.dart';
import 'package:gohealth/data/service/network_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider._internal();
  static final _singleton = AuthProvider._internal();
  factory AuthProvider() => _singleton;

  final NetworkService networkService = NetworkService();
  final LocalService localService = LocalService();
  bool _islogin = false;
  bool get isLogin => _islogin;
  String _email = '';
  String get email => _email;
  int _uid = -1;
  int get uid => _uid;
  bool _isLoading = false;
  bool get isloading => _isLoading;
  UserProfile? _userProfile;
  UserProfile? get userProfile => _userProfile;
  String? get profilePictUrl => _getProfilePictUrl();
  String? _getProfilePictUrl() {
    if (userProfile != null) {
      if (userProfile!.profilepict != null) {
        return "${NetworkService.BASEURL}/profile/photo/${userProfile!.profilepict}";
      }
    }
    return null;
  }

  Future<Response> updateProfile(
      String email, String password, String name) async {
    try {
      return networkService.updateProfile(email, password, name);
    } on SocketException {
      return Response(message: "cannot connect to server");
    } catch (e) {
      debugPrint(e.toString());
      return Response(message: "internal error");
    }
  }

  loadUserProfile() async {
    if (isLogin) {
      var _userdetail = await networkService.getProfile();
      _userProfile = _userdetail;
      notifyListeners();
    }
  }

  loadAuthDetails() async {
    var _result = await localService.getLoginStatus();
    if (_result) {
      var _details = await localService.getLoginDetails();
      _islogin = true;
      _email = "${_details['email']}";
      _uid = _details['idUser'];
      loadUserProfile();
    } else {
      _islogin = false;
      _email = '';
      _uid = -1;
    }
    notifyListeners();
  }

  update() {
    notifyListeners();
  }

  Future<ResponseUpdatePp> updatePhotoProfile(File image) async {
    try {
      var response = await networkService.updatePhotoProfile(image);
      _userProfile!.profilepict = null;
      notifyListeners();
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return ResponseUpdatePp(message: e.toString());
    }
  }

  Future<Response> login(String mail, String password) async {
    try {
      var _result = await networkService.login(mail, password);
      if (_result.result) {
        localService.saveLoginDetails(
            _result.data['email'], _result.data['uid']);
      }
      return _result;
    } on SocketException {
      return Response(message: "cannot connect to server");
    } catch (e) {
      debugPrint(e.toString());
      return Response(message: "internal error");
    }
  }

  Future<Response> register(
      String email, String password, UserProfile profile) async {
    try {
      var _result = await networkService.register(email, password, profile);
      if (_result.result) {
        localService.saveLoginDetails(
            _result.data['email'], _result.data['uid']);
      }
      return _result;
    } on SocketException {
      return Response(message: "cannot connect to server");
    } catch (e) {
      debugPrint(e.toString());
      return Response(message: "internal error");
    }
  }

  void logout() async {
    await localService.removeLoginDetails();
    loadAuthDetails();
  }
}
