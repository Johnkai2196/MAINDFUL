import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';

class HealthGpt extends StatefulWidget {
  const HealthGpt({super.key});

  @override
  State<HealthGpt> createState() => _HealthGptState();
}

class _HealthGptState extends State<HealthGpt> {
  final bool _isTyping = true;
  late TextEditingController textController;
  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const Text("data",
                      style: TextStyle(color: Colors.white));
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(
                height: 15,
              ),
              Material(
                color: const Color.fromRGBO(42, 45, 53, 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: textController,
                          onSubmitted: (value) {},
                          decoration: const InputDecoration.collapsed(
                            hintText: "Type your question here",
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(223, 183, 255, 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.check,
                            color: Color.fromRGBO(94, 23, 142, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
