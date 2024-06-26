import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLimeGreen,

        title: const Text(
          "Terms and Conditions",
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
                "1. Introduction",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "Welcome to NutriFlex. These Terms and Conditions govern your use of our mobile application ('NutriFlex' or 'the App'). By downloading, accessing, or using the App, you agree to be bound by these terms.",
              ),
              SizedBox(height: 20.0),
              Text(
                "2. Use of Services",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "NutriFlex provides health and fitness-related services, including BMI calculation, personalized diet plans, and food item scanning. You agree to use the App only for lawful purposes and in a manner that does not infringe the rights of others or restrict their use and enjoyment of the App.",
              ),
              SizedBox(height: 20.0),
              Text(
                "3. User Accounts",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "To access certain features of NutriFlex, you are required to create an account. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.",
              ),
              SizedBox(height: 20.0),
              Text(
                "4. Health Disclaimer",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "NutriFlex is intended for informational purposes only. It is not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health providers with any questions you may have regarding a medical condition.",
              ),
              SizedBox(height: 20.0),
              Text(
                "5. Intellectual Property",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "All content, trademarks, and data on NutriFlex, including but not limited to software, databases, text, graphics, icons, and hyperlinks, are the property of NutriFlex or its licensors.",
              ),
              SizedBox(height: 20.0),
              Text(
                "6. Limitation of Liability",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "NutriFlex shall not be liable for any direct, indirect, incidental, special, or consequential damages resulting from the use or inability to use the App, or for the cost of procurement of substitute services.",
              ),
              SizedBox(height: 20.0),
              Text(
                "7. Indemnification",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "You agree to indemnify and hold NutriFlex, its affiliates, officers, agents, and employees harmless from any claim or demand, including reasonable attorneys' fees, made by any third party due to or arising out of your use of the App, your violation of these terms, or your violation of any rights of another.",
              ),
              SizedBox(height: 20.0),
              Text(
                "8. Changes to Terms",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "We reserve the right to modify these Terms and Conditions at any time. Any changes will be effective immediately upon posting on the App. Your continued use of the App constitutes your acceptance of the revised terms.",
              ),
              SizedBox(height: 20.0),
              Text(
                "9. Governing Law",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "These terms shall be governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law principles.",
              ),
              SizedBox(height: 20.0),
              Text(
                "10. Contact Us",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "If you have any questions about these Terms and Conditions, please contact us at ahmadhassanst@gmail.com.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
