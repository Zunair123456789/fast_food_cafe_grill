import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'More',
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white70,
        child: Column(
          children: const [
            SizedBox(
              height: 5,
            ),
            ListTile(
                leading: Icon(Icons.location_on),
                title: Text(
                  'Store Location',
                  style: textStyle,
                ),
                trailing: Icon(Icons.navigate_next)),
            Divider(
              height: 1,
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                'Contact us',
                style: textStyle,
              ),
              trailing: Icon(Icons.navigate_next),
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              title: Text(
                'About Us',
                style: textStyle,
              ),
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              title: Text(
                'Privacy Policy',
                style: textStyle,
              ),
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              title: Text(
                'Terms and Conditions',
                style: textStyle,
              ),
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              title: Text(
                'Login',
                style: textStyle,
              ),
              trailing: Icon(Icons.login),
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
