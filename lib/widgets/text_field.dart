import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomTextField {
  static getEmailTextField(String s, TextEditingController emailController) {
    return TextField(
      controller: emailController,
      autocorrect: true,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: tr(s),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: BorderSide(color: Colors.grey),
        ),
        prefixIcon: Icon(
          Icons.alternate_email,
          color: Colors.orangeAccent,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  static getPasswordTextField(String s,
      TextEditingController passwordController, toggle, _obscureText) {
    return TextField(
      controller: passwordController,
      autocorrect: true,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: tr(s),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: BorderSide(color: Colors.grey),
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.orangeAccent,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        suffixIcon: IconButton(
          icon: _obscureText
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
          color: Color.fromARGB(255, 96, 96, 96),
          onPressed: toggle,
        ),
      ),
      obscureText: _obscureText,
    );
  }

  static getPlainTextField(String s, TextEditingController nameController) {
    return TextField(
      controller: nameController,
      autocorrect: true,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: tr(s),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: BorderSide(color: Colors.grey),
        ),
        prefixIcon: Icon(
          Icons.person_outline,
          color: Colors.orangeAccent,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  static getPlainTextFieldWithOutIcon(
      String s, TextEditingController nameController) {
    return TextField(
      controller: nameController,
      autocorrect: true,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: tr(s),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  static getDisabledPlainTextFieldWithOutIcon(
      String s, TextEditingController nameController, bool isDisabled) {
    return TextField(
      controller: nameController,
      autocorrect: true,
      enabled: isDisabled,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: tr(s),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  static getNumberFieldWithOutIcon(
      String s, TextEditingController nameController) {
    return TextField(
      controller: nameController,
      autocorrect: true,
      keyboardType: TextInputType.number,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: tr(s),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
