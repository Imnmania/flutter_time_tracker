import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

class AuthProvider extends InheritedWidget {
  final AuthBase auth;
  final Widget child;

  AuthProvider({@required this.auth, @required this.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    // throw UnimplementedError();
    return false;
  }

  static AuthBase of(BuildContext context) {
    // ignore: deprecated_member_use
    AuthProvider provider = context.inheritFromWidgetOfExactType(AuthProvider);
    return provider.auth;
  }
}
