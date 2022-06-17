import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle fontstyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    TextStyle fontstyle1 = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                  'Fast Food Cafe & Grill CORPORATION PRIVACY POLICY — YOUR PRIVACY RIGHTS',
                  style: fontstyle),
              const SizedBox(
                height: 15,
              ),
              Text('EFFECTIVE DATE: JUNE 9, 2020', style: fontstyle),
              const SizedBox(
                height: 15,
              ),
              Text('THIS PRIVACY POLICY APPLIES TO THE SITES',
                  style: fontstyle),
              const SizedBox(
                height: 25,
              ),
              Text(
                  'This Policy describes how we treat personal information both online and offline. This includes on our websites. It also includes in phone or email interactions you have with us.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'Contact information. For example, we might collect your name and street address. We might also collect your phone number or email address.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'Payment and billing information. For example, we collect your credit card number and zip code when you buy one of our products.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'Information you submit or post. If you post content, apply for a job, or respond to a survey, we will collect the information you provide to us.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'Demographic information. We may collect information about our services you like or products you buy. We might collect this as part of a survey, for example.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'Other information. If you use our website, we may collect information about your computer location or the browser you are using. We might look at what site you came from, or what site you visit when you leave us.',
                  style: fontstyle1),
              const SizedBox(
                height: 25,
              ),
              Text('WE USE INFORMATION AS DISCLOSED AND DESCRIBED HERE',
                  style: fontstyle),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'We use information to respond to your requests or questions. For example, we might use your information to confirm your registration for a program or contest, or fulfill prizes or premiums in a promotion. We may use your friends email address if you send them features on our site.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'We use information to improve our products and services. We might use your information to customize your experience with us. We may use your information to make our website and products better.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'We use information to look at site trends and customer interests. We may use your information to make our website and products better. We may combine information we get from you with information about you we get from third parties.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'We use information for security purposes. We may use information to protect our company, our customers, or our websites. For example, in the event of a breach, we may use your contact information to contact you about that incident.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'We use information for marketing purposes. For example, we might send you information about special promotions or offers. We might also tell you about new features or products. These might be our own offers or products, or third-party offers or products we think you might find interesting. To learn about your choices for these communications, read the choices section below.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'We use information to send you transactional communications. For example, we might send you emails about a purchase you made with us. We might also contact you about this policy or our website terms.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text('We use information as otherwise permitted by law.',
                  style: fontstyle1),
              const SizedBox(
                height: 25,
              ),
              Text('YOU HAVE CERTAIN CHOICES ABOUT HOW WE USE YOUR INFORMATION',
                  style: fontstyle),
              const SizedBox(
                height: 25,
              ),
              Text(
                  'You can opt out of receiving our marketing emails. To stop receiving our promotional emails, send a request to comments@fastfoodcafepakistan.com or follow the instructions in any promotional message you get from us. It may take about ten (10) days to process your request. Do not worry! Even if you opt out of getting marketing messages, we will still be sure to send you transactional messages. For example, we may still contact you about your orders.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'You can control cookies and tracking tools. To learn how to manage how we — and our vendors — use cookies and other tracking tools, please click here.',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'You can control if we share information with third parties for their marketing purposes. To opt out of having us share your information with third parties for their promotional purposes, click here.',
                  style: fontstyle1),
              const SizedBox(
                height: 25,
              ),
              Text('THESE SITES ARE NOT INTENDED FOR CHILDREN',
                  style: fontstyle),
              const SizedBox(
                height: 25,
              ),
              Text(
                  'Our sites are meant for adults. We do not knowingly collect personally identifiable information from children under 13 without permission from a parent or guardian. If you are a parent or legal guardian and think your child under 13 has given us information, you can email us here. You can also write to us at the address listed at the end of this policy. Please mark your inquiries "COPPA Information Request."',
                  style: fontstyle1),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'Parents, you can also learn more about how to protect children\'s privacy online here.',
                  style: fontstyle1),
              const SizedBox(
                height: 25,
              ),
              Text('WHAT WE WILL DO IF THERE IS AN UPDATE TO THIS POLICY',
                  style: fontstyle),
              const SizedBox(
                height: 25,
              ),
              Text(
                  'From time to time we may change our privacy practices. We will notify you of any material changes to this policy as required by law. We will also post an updated copy on our website. Please check our site periodically for updates',
                  style: fontstyle1),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
