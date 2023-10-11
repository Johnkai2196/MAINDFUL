import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';

class FitnessTile extends StatelessWidget {
  const FitnessTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: FractionallySizedBox(
          widthFactor: 0.95, // 95% of the screen width
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 104,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Text(
                          "Sleep",
                          style: TextStyle(
                            color: textPurple,
                            fontSize: 32,
                          ),
                        ),
                      ),
                      Text(
                        "8h",
                        style: TextStyle(
                          color: textWhite,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
