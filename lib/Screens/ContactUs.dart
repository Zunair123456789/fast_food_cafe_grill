import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class ContactUS extends StatelessWidget {
  const ContactUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.white),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text(
          'Help Center',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        toolbarHeight: 40,
      ),
      backgroundColor: Colors.white,
      body: ContactUs(
        textColor: Colors.white,
        companyColor: Theme.of(context).primaryColor,
        cardColor: Theme.of(context).primaryColor,
        //  logo: ,
        email: 'aliahsan78211@gmail.com',
        companyName: 'Fast Food Cafe & Grill',
        phoneNumber: '+92 303 6657152',
        // website: 'inximamb5.wixsite.com/inzimambhatti',
        githubUserName: 'https://github.com/aliahsan786',
        linkedinURL: 'https://www.linkedin.com/in/ali-ahsan-b84360182',
        tagLine: 'Home Dilevery',
        twitterHandle: 'iamInzimam',
        taglineColor: Colors.black,
        instagram: 'aliahsan786211',
        facebookHandle: 'iaminzimam',
      ),
    );
  }
}
