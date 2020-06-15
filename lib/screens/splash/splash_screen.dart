import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wetonomy/bloc/accounts/accounts_bloc.dart';
import 'package:wetonomy/bloc/accounts/accounts_event.dart';
import 'package:wetonomy/bloc/accounts/accounts_state.dart';
import 'package:wetonomy/screens/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountsBloc>(context);
    bloc.add(LoadAccountsEvent());
    

    return BlocListener<AccountsBloc, AccountsState>(
      bloc: bloc,
      listener: (BuildContext context, AccountsState state) {
        if (state is AccountsLoadedState) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen(
                        accounts: state.accounts,
                      )));
        } else if (state is EmptyAccountsState) {
          Navigator.pushReplacementNamed(context, '/welcome');
        }
      },
      child: Material(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: SvgPicture.asset('assets/images/logo.svg'),
          ),
        ),
      ),
    );
  }
}
