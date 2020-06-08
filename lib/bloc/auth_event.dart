part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}


class StartLogin extends AuthEvent
{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}


class LogOut extends AuthEvent
{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}
class GetUser extends AuthEvent
{

  
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}
class IsLoggedIn extends AuthEvent
{

  
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}