import 'package:fast_food_cafe_grill/Provider/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class NumberAuth extends StatefulWidget {
  const NumberAuth({Key? key}) : super(key: key);

  @override
  _NumberAuthState createState() => _NumberAuthState();
}

class _NumberAuthState extends State<NumberAuth> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;

  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Number Authentication",
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone number"),
              keyboardType: TextInputType.phone,
              style: TextStyle(decorationColor: Theme.of(context).primaryColor),
            ),
            Visibility(
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(),
                keyboardType: TextInputType.number,
              ),
              visible: otpVisibility,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                onPressed: () {
                  if (otpVisibility) {
                    verifyOTP();
                  } else {
                    loginWithPhone();
                  }
                },
                child: Text(
                  otpVisibility ? "Verify" : "Login",
                )),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('number add');
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      Provider.of<Auth>(context, listen: false).setPhone(phoneController.text);
      Fluttertoast.showToast(
          msg: "Phone Number successfully added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Provider.of<Auth>(context, listen: false).phoneToFirestore();
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    });
  }
}
