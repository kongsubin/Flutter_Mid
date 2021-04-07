
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // TODO: Add text editing controllers (101)
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Container _textFormField(String content, TextEditingController inputController, bool isPassword) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: inputController,
        decoration: InputDecoration(
          filled: true,
          labelText: content,

        ),
        obscureText: isPassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ' + content;
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 150.0),
              // [username]
              _textFormField('Username', _usernameController, false),
              // [Password]
              _textFormField('Password', _passwordController, true),
              // [Confirm Password]
              _textFormField('Confirm Password', _confirmPasswordController, true),
              // [email address]
              _textFormField('Address', _emailAddressController, false),
              ButtonBar(
                buttonPadding: EdgeInsets.all(10),
                // TODO: Add a beveled rectangular border to CANCEL (103)
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white38, // background
                    ),
                    child: Text('SIGN UP',
                      style: TextStyle(
                        color: Colors.black,
                      ),),
                    onPressed: () {
                      // TODO: Show the next page (101)
                      if (_formKey.currentState.validate()) {
                        Navigator.pop(context);
                      }
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}