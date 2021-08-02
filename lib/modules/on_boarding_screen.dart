import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_application/models/boarding_model.dart';
import 'package:shop_application/modules/login_screen.dart';
import 'package:shop_application/share/component/component.dart';
import 'package:shop_application/share/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';





class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast= false;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true)
        .then((value)
    {
      if(value )navigateAndFinish(context, LoginScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    var scrollPage = PageController();
    return Scaffold(
        appBar: AppBar(
          actions: [
       defaultTextBottom(text:'skip',
              function:submit
       )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index)
                  {

                    if(index==boardingList.length-1)
                    {
                      setState(() {
                        isLast=true ;
                      });
                      print('Last');
                    }else{
                      setState(() {
                        isLast=false ;
                      });
                    }
                  },
                  controller: scrollPage,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boardingList[index]),
                  itemCount: boardingList.length,
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      effect: ExpandingDotsEffect(
                          activeDotColor: Colors.blue[800],
                          strokeWidth: 4.0,
                          spacing: 9,
                          dotHeight:10.0),
                      controller: scrollPage,
                      count: boardingList.length),
                  Spacer(),
                  FloatingActionButton(
                      child: Icon(Icons.arrow_forward_ios_outlined),
                      onPressed: ()
                      {
                        if(isLast)
                        {
                        submit();
                        }else{
                          scrollPage.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn, 

                          );
                        }

                      }),
                ],
              ),
            ],
          ),
        ));
  }
}


