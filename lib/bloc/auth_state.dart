part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}


class AuthLogingIn extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoggedIn extends AuthState {
  final User user;

  AuthLoggedIn({this.user});
  @override
  List<Object> get props => [user];
}
class AuthFailed extends AuthState {
  final String msg;

  AuthFailed({this.msg});
  @override
  List<Object> get props => [msg];
}
class AuthUser extends AuthState {
  final User user;

  AuthUser({this.user});
  @override
  List<Object> get props => [user];
}
class IsUser extends AuthState {
  final bool user;

  IsUser({this.user});
  @override
  List<Object> get props => [user];
}

