import 'package:cttgfahrer/config/UIFeedback.dart';
import 'package:cttgfahrer/model/register_model.dart';
import 'package:cttgfahrer/widgets/custom_button.dart';
import 'package:cttgfahrer/widgets/custom_header.dart';
import 'package:cttgfahrer/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'bloc/bloc/register_block_bloc.dart';

class RegisterStateLess extends StatelessWidget {
  @override
  Widget build(BuildContext conext) {
    return BlocProvider<RegisterBlockBloc>(
      create: (BuildContext context) => RegisterBlockBloc(),
      child: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(prefs.getString("locale"));
    if (prefs.getString("locale") == "en_US")
      prefs.setString("locale", "de_AT");
    else
      prefs.setString("locale", "en_US");
    RegisterBlockBloc _registerBloc =
        BlocProvider.of<RegisterBlockBloc>(context);
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(25, 60, 25, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomHeader.getMainHeader('register', context),
          CustomHeader.getSubHeader('registerSubheader', context),
          CustomTextField.getEmailTextField('email', emailController),
          SizedBox(
            height: 20,
          ),
          CustomTextField.getPlainTextField('name', nameController),
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
                _registerBloc.add(
                  RequestRegisterEvent(
                    RegisterModel(
                        email: emailController.text,
                        name: nameController.text,
                        password: passwordController.text),
                  ),
                );
              }
            },
            child: CustomButton.getButton('register', context),
          ),
          SizedBox(
            height: 10,
          ),
          BlocListener<RegisterBlockBloc, RegisterBlockState>(
            bloc: _registerBloc,
            listener: (context, state) {
              if (state is RegisterBlockError) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.response.responseMessage),
                ));
              } else if (state is RegisterBlockSuccess) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);

                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.getResponse.responseMessage),
                ));
              }
            },
            child: BlocBuilder<RegisterBlockBloc, RegisterBlockState>(
                builder: (context, state) {
              print(state.toString());
              if (state is RegisterBlockProcessing) {
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
                    '/login', (Route<dynamic> route) => false);
              },
              child: Text("linkToLogin").tr(context: context))
        ],
      ),
    ));
  }

  bool validateInputs() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      UIFeedback.showToast(tr("allFieldMandatory"));
      return false;
    }
    // if (!RegExp(
    //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //     .hasMatch(emailController.text)) {
    if (!emailController.text.contains("@")) {
      UIFeedback.showToast(tr("invalidEmail"));
      return false;
    }
    if (passwordController.text.length < 8) {
      UIFeedback.showToast(tr("invalidPassword"));
      return false;
    }
    return true;
  }
}
