import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:innovation_project/pages/home_page.dart';
import 'package:innovation_project/providers/chat_providers.dart';
import 'package:innovation_project/providers/health_providers.dart';
import 'package:innovation_project/providers/quote_providers.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        ChangeNotifierProvider(
          create: (_) =>
              HealthDataProvider(), // Add the HealthDataProvider here
        ),
        ChangeNotifierProvider(
          create: (_) => QuoteProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
