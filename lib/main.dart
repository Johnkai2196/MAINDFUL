import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:innovation_project/pages/home_page.dart';
import 'package:innovation_project/providers/chat_providers.dart';
import 'package:innovation_project/pages/healthkpi.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HealthKpi(),
      ),
    );
  }
}
