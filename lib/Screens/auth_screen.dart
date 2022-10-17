// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'package:fast_food_cafe_grill/Provider/Auth.dart';
import 'package:fast_food_cafe_grill/Screens/Reset_Password.dart';
import 'package:fast_food_cafe_grill/models/http_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login, phoneVerified }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final image = Image.network(
        'https://firebasestorage.googleapis.com/v0/b/fast-food-cafe-and-grill.appspot.com/o/extraImages%2Fplaystore-removebg-preview.png?alt=media&token=d4971ab1-1ac7-4682-9f25-60eee7982b7c');

    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
              // decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     const Color.fromARGB(255, 57, 54, 255).withOpacity(0.5),
              //     const Color.fromARGB(255, 204, 117, 255).withOpacity(0.9),
              //   ],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   stops: const [0, 1],
              // ),
              // ),
              ),
          Container(
            height: deviceSize.height * 0.5,
            color: Theme.of(context).primaryColor,
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: SizedBox(
                        height: deviceSize.height * 0.35,
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/fast-food-cafe-and-grill.appspot.com/o/extraImages%2Fplaystore-removebg-preview.png?alt=media&token=d4971ab1-1ac7-4682-9f25-60eee7982b7c')
                        // child: Container(
                        //   margin: const EdgeInsets.only(bottom: 20.0),
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 8.0, horizontal: 94.0),
                        //   transform: Matrix4.rotationZ(-8 * pi / 180)
                        //     ..translate(-10.0),
                        //   // ..translate(-10.0),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //     color: Colors.deepOrange.shade900,
                        //     boxShadow: const [
                        //       BoxShadow(
                        //         blurRadius: 8,
                        //         color: Colors.black26,
                        //         offset: Offset(0, 2),
                        //       )
                        //     ],
                        //   ),
                        //   child: Text(
                        //     'FastFood Cafe & Grill ',
                        //     style: TextStyle(
                        //       color: Theme.of(context).primaryColor,
                        //       fontSize: 30,
                        //       fontFamily: 'Anton',
                        //       fontWeight: FontWeight.normal,
                        //     ),
                        //   ),
                        // ),
                        ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'fname': '',
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  AnimationController? _controller;
  Animation<Size>? _heightAnimation;
  @override
  void initState() {
    // TODO: implement initState/
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 300,
        ));
    _heightAnimation = Tween<Size>(
            begin: const Size(double.infinity, 340),
            end: const Size(double.infinity, 420))
        .animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.bounceInOut,
    ));
    _heightAnimation!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An error Occoured'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('OK'))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'].toString(),
          _authData['password'].toString(),
        );
      } else {
        // Sign user up
        Provider.of<Auth>(context, listen: false)
            .setname(_authData['fname'].toString());
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'].toString(),
          _authData['password'].toString(),
        );
      }
    } on HttpException catch (error) {
      var errorMassage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMassage = errorMassage;
      } else if (error.toString().contains('badly formatted')) {
        errorMassage = 'This is not a valid email address.';
      } else if (error.toString().contains('weak-password')) {
        errorMassage = 'This is password is too weak.';
      } else if (error.toString().contains('no user record corresponding')) {
        errorMassage =
            'There is no user record corresponding to this email. The user may have been deleted.';
      } else if (error.toString().contains('password is invalid')) {
        errorMassage = 'This is invalid Password.';
      }
      _showErrorDialog(errorMassage);
    } catch (error) {
      var errorMassage = 'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMassage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    setState(() {
      _authData = {
        'fname': '',
        'email': '',
        'password': '',
      };
    });
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _heightAnimation!.value.height,
        constraints: BoxConstraints(minHeight: _heightAnimation!.value.height),
        width: deviceSize.width * 0.85,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(
                          Icons.person,
                        )),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid Full Name!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['fname'] = value!;
                    },
                  ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'E-Mail',
                      prefixIcon: Icon(
                        Icons.email,
                      )),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Login)
                  const SizedBox(
                    height: 20,
                  ),
                if (_authMode == AuthMode.Login)
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResetPassword()));
                    },
                    child: Text(
                      'Don\'t Remember your Password?',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock)),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    FlatButton(
                      child: Text(
                          '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                      onPressed: _switchAuthMode,
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 30.0, vertical: 4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
