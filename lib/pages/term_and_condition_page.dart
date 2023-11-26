import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';
import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/providers/health_providers.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsPage extends StatelessWidget {
  final HealthDataProvider healthDataProvider;
  final String question;
  final String route;
  const TermsAndConditionsPage(
      {super.key,
      required this.healthDataProvider,
      this.question = "",
      this.route = ""});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.95;
    double cardHeight = MediaQuery.of(context).size.height * 0.70;
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
                  color: surfaceContainerHighest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Terms and conditions',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
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
                                    ..onTap = () {
                                      _launchUrl();
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
                  TextButton(
                    onPressed: () {
                      // Add functionality for the button
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        // backgroundColor: textPurple,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(
                        //       100.0), // Adjust the radius as needed
                        // ),
                        ),
                    child: const Text(
                      'Decline',
                      style: TextStyle(
                        color: Color.fromRGBO(223, 183, 255, 1),
                        fontSize: 14,
                        // You can customize the text style if needed
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _setPreferences();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HealthGpt(
                              healthDataProvider: healthDataProvider,
                              question: question,
                              route: route),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: textPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            100.0), // Adjust the radius as needed
                      ),
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        // You can customize the text style if needed
                        color: Color.fromRGBO(75, 0, 126, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

Future<void> _launchUrl() async {
  final Uri url = Uri.parse('https://openai.com/policies/privacy-policy');
  if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $url');
  }
}

void _setPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('status', true);
}
