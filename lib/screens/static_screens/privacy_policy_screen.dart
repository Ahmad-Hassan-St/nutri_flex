import 'package:flutter/material.dart';
import 'package:lifefit/constants/colors.dart';

class PrivacyPolicyNutriFlexScreen extends StatelessWidget {
  const PrivacyPolicyNutriFlexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLimeGreen,
        title: const Text(
          "Privacy Policy",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NutriFlex Privacy Policy",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Text(
                "1. Introduction",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use NutriFlex.",
              ),
              SizedBox(height: 20.0),
              Text(
                "2. Information We Collect",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "- Personal Information: We may collect personally identifiable information such as your name, email address, gender, height, weight, and other health-related information when you create an account or use the App.",
              ),
              Text(
                "- Usage Data: We may collect information about your interactions with the App, such as IP addresses, browser type, pages visited, and the time and date of your visits.",
              ),
              Text(
                "- Health Data: Information related to your BMI, fat mass, body composition, and dietary preferences collected through your use of the App.",
              ),
              SizedBox(height: 20.0),
              Text(
                "3. Use of Information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "We use the information we collect to:",
              ),
              Text(
                "- Provide, operate, and maintain the App.",
              ),
              Text(
                "- Improve, personalize, and expand the App’s features.",
              ),
              Text(
                "- Develop personalized diet plans and health assessments.",
              ),
              Text(
                "- Communicate with you, including for customer service, updates, and marketing purposes.",
              ),
              Text(
                "- Process transactions and manage your account.",
              ),
              SizedBox(height: 20.0),
              Text(
                "4. Sharing of Information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "We do not sell, trade, or otherwise transfer your personal information to outside parties except as described in this policy. We may share your information with:",
              ),
              Text(
                "- Service Providers: Third-party service providers who assist us in operating the App.",
              ),
              Text(
                "- Legal Requirements: We may disclose your information if required to do so by law or in response to valid requests by public authorities.",
              ),
              SizedBox(height: 20.0),
              Text(
                "5. Data Security",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "We implement appropriate security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction.",
              ),
              SizedBox(height: 20.0),
              Text(
                "6. Your Rights",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "You have the right to access, correct, or delete your personal information. You may also have the right to object to or restrict certain types of data processing. To exercise these rights, please contact us at [Your Contact Information].",
              ),
              SizedBox(height: 20.0),
              Text(
                "7. Changes to This Policy",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy on the App. You are advised to review this Privacy Policy periodically for any changes.",
              ),
              SizedBox(height: 20.0),
              Text(
                "8. Contact Us",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "If you have any questions about this Privacy Policy, please contact us at ahmadhassanst@gmail.com.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
