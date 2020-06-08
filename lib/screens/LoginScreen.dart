import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixiwall/bloc/auth_bloc.dart';
import 'package:pixiwall/main.dart';
import 'package:pixiwall/repositories/AuthRepo.dart';
import 'package:pixiwall/screens/Home.dart';
import 'package:pixiwall/shared/colors.dart';
import 'package:pixiwall/shared/consts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(authRepo: AuthRepo()),
      child: Scaffold(
        backgroundColor: Primary,
        body: SingleChildScrollView(
          child: Container(
            width: w(context),
            height: h(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BlocListener<AuthBloc, AuthState>(listener: (context, state) {
                  if (state is AuthLoggedIn) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => App()));
                  }
                }, child:
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  if (state is AuthInitial) {
                    return InkWell(
                      onTap: () async {
                        print('Hello');
                        context.bloc<AuthBloc>().add(StartLogin());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: Container(
                            width: w(context) / 1.15,
                            height: h(context) / 12,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'SIGN UP WITH',
                                  style: TextStyle(
                                      color: Primary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(width: 30),
                              ],
                            )),
                      ),
                    );
                  } else if (state is AuthLogingIn) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AuthLoggedIn) {
                    print("Looged in");
                    //  Navigator.pushNamed(context, '/',arguments: {"auth":state.user});
                    return Container();
                    // return Home();
                  } else if (state is AuthFailed) {
                    Text('${state.msg}');
                  }
                })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
