import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pixiwall/model/User.dart';
import 'package:pixiwall/repositories/AuthRepo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  AuthBloc({@required AuthRepo authRepo})
      : assert(authRepo != null),
        _authRepo = authRepo;
  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is StartLogin) {
      yield* login();
    } else if (event is LogOut) {
      yield* logoutFun();
    } else if (event is GetUser) {
      yield* getUser();
    } else if (event is IsLoggedIn) {
      yield* isLogged();
    }
  }

  Stream<AuthState> loginProcess() async* {
    try {
      print("Log in");
      User usr = await _authRepo.signInWithGoogle();
      yield AuthLoggedIn(user: usr);
    } catch (e) {
      AuthFailed(msg: e.toString());
    }
  }

  Stream<AuthState> login() async* {
    yield AuthLogingIn();
    yield* loginProcess();
  }

  Stream<AuthState> logoutFun() async* {
    try {
      await _authRepo.signOutGoogle();
      yield AuthUser(user: null);
    } catch (e) {
      print("Logged Out");
    }
  }

  Stream<AuthState> getUser() async* {
    try {
      bool islogged = await _authRepo.isLoggedIn;
      print(islogged);
      if (islogged) {
        User usr = await _authRepo.user;

        print(usr.uid);
        yield AuthUser(user: usr);
      } else {
        yield AuthUser(user: null);
      }
    }

//  yield*
    catch (e) {
      print(e);
    }
  }

  Stream<AuthState> isLogged() async* {
    try {
      bool islogged = await _authRepo.isLoggedIn;
      yield IsUser(user: islogged);
//  yield*
    } catch (e) {
      print("error");
    }
  }
}
