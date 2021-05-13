import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../constants.dart';

class onboardscreen extends StatefulWidget {
  @override
  _onboardscreenState createState() => _onboardscreenState();
}
final _controller = PageController(
  initialPage: 0,
);
int _currentpage=0;
List<Widget> _pages = [

 Column(
      children: [
        Expanded(child: Image.asset('images/9.png')),
        
        Text('Buy books from your known seniors', style: kPageViewTextStyle,),
      ],
    ),
  

  Column(
    children: [
      Expanded(child: Image.asset('images/cycle.png')),
      Text('Rent/Buy cycles to roam:)', style: kPageViewTextStyle),
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('images/hands.png')),
      Text('shake hands with partner', style: kPageViewTextStyle,),
    ],
  ),

];
class _onboardscreenState extends State<onboardscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children:[ Expanded(
          child: PageView(
            controller: _controller,
            children: _pages,
            onPageChanged: (index){
              setState(() {
                _currentpage = index;
              });


            },
          ),
        ),
          SizedBox(height: 20,),
          DotsIndicator(
            dotsCount: _pages.length,
            position: _currentpage.toDouble(),
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              activeColor: Colors.red,
            ),
          ),
          SizedBox(height: 20,),
      ],
      ),
    );
  }
}

