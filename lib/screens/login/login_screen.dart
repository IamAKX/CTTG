import 'package:cttgfahrer/config/UIFeedback.dart';
import 'package:cttgfahrer/model/login_model.dart';
import 'package:cttgfahrer/screens/login/bloc/bloc/login_bloc.dart';
import 'package:cttgfahrer/widgets/custom_button.dart';
import 'package:cttgfahrer/widgets/custom_header.dart';
import 'package:cttgfahrer/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class LoginStateLess extends StatelessWidget {
  @override
  Widget build(BuildContext conext) {
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(),
      child: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  LoginBloc _loginBloc;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: loginBody(),
    );
  }

  Widget loginBody() {
    print(prefs.getString("locale"));
    if (prefs.getString("locale") == "en_US")
      prefs.setString("locale", "de_AT");
    else
      prefs.setString("locale", "en_US");

    setState(() {});
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(25, 60, 25, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomHeader.getMainHeader('login', context),
          CustomHeader.getSubHeader('loginSubheader', context),
          CustomTextField.getEmailTextField('email', emailController),
          SizedBox(
            height: 20,
          ),
          CustomTextField.getPasswordTextField(
              'password', passwordController, _toggle, _obscureText),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if (validateInputs()) {
                _loginBloc.add(
                  RequestLoginEvent(
                    LoginModel(
                        email: emailController.text,
                        password: passwordController.text),
                  ),
                );
              }
            },
            child: CustomButton.getButton('login', context),
          ),
          SizedBox(
            height: 10,
          ),
          BlocListener<LoginBloc, LoginState>(
            bloc: _loginBloc,
            listener: (context, state) {
              if (state is LoginFail) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.response.responseMessage),
                ));
              } else if (state is LoginSuccess) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false);

                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.getResponse.responseMessage),
                ));
              }
            },
            child:
                BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              print(state.toString());
              if (state is LoginProcessing) {
                return LinearProgressIndicator();
              }
              return Container();
            }),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/register', (Route<dynamic> route) => false);
              },
              child: Text("linkToRegister").tr(context: context))
        ],
      ),
    );
  }

  bool validateInputs() {
    if (emailController.text.isEmpty) {
      UIFeedback.showToast(tr("enterEmail"));
      return false;
    }
    if (passwordController.text.isEmpty) {
      UIFeedback.showToast(tr("enterPassword"));
      return false;
    }
    return true;
  }
}
