import 'package:fast_food_cafe_grill/Provider/Cafe.dart';
import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';
import 'package:provider/provider.dart';

class ContactUS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cafe = Provider.of<Cafe>(context).findById();
    final cafeVisibility = Provider.of<Cafe>(context);
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
        body: cafeVisibility.isSelected == ''
            ? const Center(
                child: Text(
                    'Please select any cafe from the home screen to view the data'),
              )
            : ContactUs(
                textColor: Colors.white,
                companyColor: Theme.of(context).primaryColor,
                cardColor: Theme.of(context).primaryColor,
                //  logo: ,
                email: cafe.cafeMail,
                companyName: cafe.cafeName,
                phoneNumber: cafe.cafephone,
                // website: 'inximamb5.wixsite.com/inzimambhatti',
                // githubUserName: 'https://github.com/aliahsan786',
                // linkedinURL: 'https://www.linkedin.com/in/ali-ahsan-b84360182',
                tagLine: 'Home Dilevery',
                // twitterHandle: 'iamInzimam',s
                taglineColor: Colors.black,
                instagram: 'aliahsan786211',
                facebookHandle: cafe.cafefacebook,
              ));
  }
}
