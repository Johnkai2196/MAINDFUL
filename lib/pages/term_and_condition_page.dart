import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.95;
    double cardHeight = MediaQuery.of(context).size.height * 0.75;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: cardWidth,
                height: cardHeight,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFF373437),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text.rich(
                            TextSpan(
                              text:
                                  'MAINDFUL is powered by the OpenAI API. Data submitted here is not used for training OpenAI\'s models according to their terms and conditions.\n\nCurrently, MAINDFUL is accessing your step count, sleep analysis, VO2MAX and heartbeat all from data stored in the Health app.\n\nRemember to log your data and wear your Apple Watch throughout the day for the most accurate results.\n\nMAINDFUL is provided for general informational purposes only and is not intended as a substitute for professional medical advice, diagnosis, or treatment. Large language models, such as those provided by OpenAI, are known to hallucinate and at times return false information. The use of MAINDFUL is at your own risk. Always consult a qualified healthcare provider for personalized advice regarding your health and well-being. Aggregated HealthKit data for the past 7 days will be uploaded to OpenAI.  Your data will be preserved for 30 days. Your data will not be used to train the AI models. Please refer to the ',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'OpenAI privacy policy',
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      const url = Uri.parce(
                                          'https://openai.com/privacy-policy/');
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                ),
                                const TextSpan(
                                  text: ' for more information.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the first button
                    },
                    child: const Text('Button 1'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the second button
                    },
                    child: const Text('Button 2'),
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
