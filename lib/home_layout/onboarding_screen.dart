import 'package:flutter/material.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/shared/natwork/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/boarding_model.dart';
import '../shared/colors.dart';
import '../shared/component/component_board.dart';
import '../shared/constant.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  var boardController = PageController();

  void saveData() {
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true)!.then((value) {
      navigatorFinish(context, LoginScreen());
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {saveData();},
            child: Text(
              'Skip',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                  fontSize: 22),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                if (index == list.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              itemBuilder: (context, index) => boardingItem(list[index],
                  controller: boardController, onChange: (index) {
                index = list[index];
              }),
              itemCount: list.length,
              physics: BouncingScrollPhysics(),
              controller: boardController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController, // PageController
                  count: 3,
                  effect: ExpandingDotsEffect(
                      dotHeight: 10,
                      expansionFactor: 4,
                      spacing: 5.0,
                      dotWidth: 10,
                      activeDotColor: defaultColor), // your preferred effect
                ),
                Spacer(),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    clipBehavior: Clip.antiAlias,
                    onPressed: () {
                      if (isLast) {
                        saveData();                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
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
