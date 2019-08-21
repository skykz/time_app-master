import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:time_app/main.dart';
import 'package:time_app/utils/common_utils.dart';

class Splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen()); // define it once at root level.
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}
class SplashScreenState extends State<SplashScreen>{


    @override
    void initState() {
    super.initState();

    new Timer(new Duration(milliseconds: 1000), () {
      checkFirstSeen();
    });
    
  }

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(      
      home: new Scaffold(        
        body: new Center(
          child: SvgPicture.asset('assets/images/logo.svg',
          height: screenAwareHeight(160, context),
          width: screenAwareWidth(200, context)),
        ),    
      ),            
    );
  }


  Future checkFirstSeen() async {

    ///async method that's why I used await(waiting response or result from source)...
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new TimeApp()));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

}

/// welcome-intro class
class IntroScreen extends StatelessWidget {

  static TextStyle style = TextStyle(fontSize: 20.0,);
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
        PageViewModel(
        pageColor: const Color(0xFFFFFFFF),
        bubble: SvgPicture.asset('assets/images/system_icons/search.svg'),
        body: Text(
//          'Welcome  to  intro  slider  in  flutter  with  package  intro  views  flutter  latest  update',
          'Welcome  to  Turtle  Haselfree   booking   of   truck   with   awesome   experience ',style: style,
        ),
        title: Text(''),
        textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.green),
        
        mainImage: SvgPicture.asset('assets/images/system_icons/search.svg',alignment: Alignment.center)),
        PageViewModel(
          pageColor: const Color(0xFFFFFFFF),
          //iconImageAssetPath: 'assets/images/system_icons/money.svg',
          bubble: SvgPicture.asset('assets/images/system_icons/money.svg'),
          body: Text(
    //        'Amazevalley  intoduce  you  with  the  latest  features  coming  in  flutter  with  practical  demos',
            'Turtle  work  for  the  truck solution  which  helps  to  all  the  vendors  to  book  a  truck  on  your  fingers',style: style,
          ),
          title: Text(''),
          mainImage: SvgPicture.asset('assets/images/system_icons/money.svg',alignment: Alignment.center),
          textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.green),
        ),
        PageViewModel(
          pageColor: const Color(0xFFFFFFFF),
          bubble: SvgPicture.asset('assets/images/system_icons/fovarite.svg'),
          body: Text(
    //        'Amazevalley  give  you  brief  soluton  about  technology  where  you  fall  in  love',
            'Tutle  is the solution  of  truck  booking  at  your  doorstep  with  cashless  payment  system.',style: style,
          ),
          title: Text(''),
          mainImage: SvgPicture.asset('assets/images/system_icons/fovarite.svg',alignment: Alignment.center),
          textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.green),
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      debugShowCheckedModeBanner: false,
      title: 'IntroViews Flutter', 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) => IntroViewsFlutter( pages,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TimeApp(),
              ),
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.greenAccent,
            fontSize: 18.0,
          ),
        ), 
      ),
    );
  }
}
