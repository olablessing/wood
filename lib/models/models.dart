import 'package:flutter/material.dart';
export 'package:provider/provider.dart';
import 'package:wood_cafe/tools.dart' as tools;

import 'cart.dart';
export 'cart.dart';

/// This is a state models that manages, the global state of the application
class GlobalState extends ChangeNotifier {
  final CartState cartState = CartState();

  // set the initial data and return a map containing the
  Future<GlobalState> setInitData() async {
    _firstTime = (await tools.getFromStore('firstTime')) ?? true;
    tools.putInStore('firstTime', false);

    Map? profile = await tools.getFromStore('profile');
    _isLoggedIn = profile != null;
    if (_isLoggedIn) {
      setData(profile!);
    }

    return this;
  }

  bool _firstTime = true;
  bool get firstTime {
    return _firstTime;
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn {
    return _isLoggedIn;
  }

  Profile? _profile;
  Profile? get profile {
    return _profile;
  }

  set profile(_) => throw Exception("You can't manually set the profile,"
      "so don't try to!, use setData");

  Profile setData(Map data) {
    _profile = Profile.fromJson(data);
    tools.putInStore('profile', data);
    tools.putInStore('accessToken', data['token']);
    notifyListeners();
    return _profile!;
  }

  void logout() {
    _isLoggedIn = false;
    tools.removeFromStore('profile');
    tools.removeFromStore('accessToken');
  }
}

class Profile {
  late String token;

  Profile.fromJson(json) {
    token = json['token'];
  }
}
