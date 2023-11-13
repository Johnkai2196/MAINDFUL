import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HealthKpi extends StatelessWidget {
  const HealthKpi({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.height * 1,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/aerial-1822139_1280.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF0093DF),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF0093DF).withOpacity(0.4),
                            spreadRadius: 10,
                            blurRadius: 5,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/aerial-1822139_1280.png',
                          fit: BoxFit.cover,
                          width: 300,
                          height: 300,
                        ),
                      ),
                    ),
                    Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sleep',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            SvgPicture.asset(
                              'assets/icons/moon-svgrepo-com.svg',
                              color: Colors.white,
                              height: 32,
                              width: 32,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Lorem ipsum dolor sit amet,',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'You had a restful night\'s sleep',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'Why you should sleep?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Container(
                    height: 2,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Quality sleep is your body\'s natural way of rejuvenating and recharging. It provides the energy and vitality needed to embrace each new day with enthusiasm, helping you feel your best both mentally and physically.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Button action
                    },
                    child: Text('Lorem Ipsum'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
