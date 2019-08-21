import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:time_app/screens/camera.dart';
import 'package:time_app/screens/home/home_screen.dart';
import 'package:time_app/screens/profile/profile_data.dart';
import 'dart:async';

import 'package:time_app/utils/common_utils.dart';
import 'package:time_app/resources/components/primary_button.dart';
import 'package:time_app/resources/values/app_colors.dart';
import 'package:time_app/bloc/authorization_bloc.dart';
import 'package:time_app/bloc/bloc_provider.dart';
import 'package:time_app/bloc/application_bloc.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:flue';

class AuthorizationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthorizationScreenState();
  }
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _smsCountdown = 50;
  PageController _pageController = PageController(initialPage: 0);

  AuthorizationBloc bloc;
  ApplicationBloc appBloc;

  Timer _timer;

  Country _country = Country(isoCode: 'kz', phoneCode: '7');
  String _countryCode = '7'; // Default country code is for Kazakhstan
  bool _smsCodeSent = false;

  MaskedTextController _phoneValueController = MaskedTextController(mask: '(000) 000 00 00'); //phone number mask
  MaskedTextController _codeValueController = MaskedTextController(mask: '0 0 0 0 0 0');// sms mask code

  TextEditingController _smsCodeValueController = TextEditingController();

  @override
  void initState() {
    bloc = BlocProvider.of<AuthorizationBloc>(context);
    _countryCode = '+${_country.phoneCode}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: WillPopScope(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: screenAwareHeight(550, context),
                ),
                // Center(
                //   child: SvgPicture.asset(
                //     'assets/images/logo.svg',
                //     color: AppColors.primaryAppColor,
                //     height: screenAwareHeight(200, context),
                //     width: screenAwareWidth(300, context),
                //   ),
                // ),                                
                NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowGlow();
                    return false;
                  },
                  child: SizedBox(
                    height: screenAwareHeight(1080.0, context),
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: <Widget>[
                        _buildPhoneInputPage(),
                        _buildCodeInputPage()
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: screenAwareHeight(50, context),
                ),
                Text(
                  'Начните зарабатывать сейчас!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenAwareHeight(43, context),
                  ),
                ),
                // gesture i don't know for what =)
                new GestureDetector(                  
                  onTap: (){
                    // just used route, to check to optimization in future
                      Navigator.pushNamed(context,"auth/specialist");
                  },
                child: new Text(                  
                  'Войдите как предприниматель',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenAwareHeight(35, context),
                    decoration: TextDecoration.underline
                  ),            
                ),
                ),
              ],
            ),
            onWillPop: () => exitApp(context)));
  }

  ////////////////////////////////////////////////////////////////////
  // Building UI elements
  ////////////////////////////////////////////////////////////////////

  Widget _buildPhoneInputPage() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: screenAwareHeight(90, context),
        ),
        Text(
          'Войти с помощью номера',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: screenAwareHeight(52, context)),
        ),
        SizedBox(
          height: screenAwareHeight(30, context),
        ),
        _buildPhoneNumberInputField(),
        SizedBox(
          height: screenAwareHeight(40, context),
        ),
        Center(
          child: Text.rich(
            TextSpan(
              text: 'Продолжая, Вы соглашаетесь c ',
              style: TextStyle(fontSize: 12),
              children: <TextSpan>[
                TextSpan(
                    text: 'правилами сервиса',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    )),
                // can add more TextSpans here...
              ],
            ),
          )
        ),
         SizedBox(
          height: screenAwareHeight(50, context),
        ),
        PrimaryButton(
          gradientColors: AppColors.confirmButtonGradientColors,
          gradientStops: AppColors.primaryButtonGradientStops,
          buttonText: 'Получить код',
          height: screenAwareHeight(120, context),
          width: screenAwareWidth(600, context),
          onPressed: () => _sendSms(),
        ),
        // PrimaryButton(
        //   onPressed:() => _signOut() ,
        //   gradientColors: AppColors.confirmButtonGradientColors,
        //   gradientStops: AppColors.primaryButtonGradientStops,
        //   buttonText: 'Выйти',
        //   height: screenAwareHeight(100, context),
        //   width: screenAwareWidth(600, context),
        // )
      ],
    );
  }

  Widget _buildCodeInputPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: screenAwareHeight(60, context),
        ),
        Text(
          'Введите код',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: screenAwareHeight(62, context)),
        ),
        SizedBox(
          height: screenAwareHeight(40, context),
        ),
        _buildCodeInputField(),
        SizedBox(
          height: screenAwareHeight(56, context),
        ),
        SizedBox(
          height: screenAwareHeight(90, context),
          width: screenAwareWidth(650, context),
          child: Text(
            _smsCodeSent
                ? 'Вы получите SMS код в течение 00:$_smsCountdown сек.'
                : '',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: screenAwareHeight(56, context),
        ),
        _buildCodeInputButtons(),
        SizedBox(
          height: screenAwareHeight(30, context),
        ),
      ],
    );
  }

//  Widget _buildBackgroundImage() {
//    return Stack(
//      children: <Widget>[
//        Container(
//          alignment: Alignment.topCenter,
//          height: screenAwareHeight(1280.0, context),
//          decoration: BoxDecoration(
//            image: DecorationImage(
//                image: ExactAssetImage(
//                    'assets/images/authorization_bg.jpg'),
//                fit: BoxFit.cover,
//                colorFilter: ColorFilter.mode(
//                    Color.fromRGBO(0, 0, 0, 110), BlendMode.darken)),
//            border: Border.all(style: BorderStyle.none),
//            borderRadius: BorderRadius.only(
//                bottomLeft: Radius.circular(screenAwareHeight(90, context)),
//                bottomRight: Radius.circular(screenAwareHeight(90, context))),
//          ),
//        ),
//        _buildLogoAndSlogan()
//      ],
//    );
//  }

//  Widget _buildLogoAndSlogan() {
//    TextStyle sloganStyle = TextStyle(
//        color: Colors.white, fontSize: screenAwareHeight(52, context));
//
//    return Positioned(
//      top: screenAwareHeight(280, context),
//      left: screenAwareWidth(120, context),
//      child: SizedBox(
//        height: screenAwareHeight(760, context),
//        width: screenAwareWidth(640, context),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            SvgPicture.asset(
//              'assets/images/logo.svg',
//              color: Colors.white,
//              height: screenAwareHeight(200, context),
//              width: screenAwareWidth(300, context),
//            ),
//            SizedBox(
//              height: screenAwareHeight(100, context),
//            ),
//            Container(
//              height: screenAwareHeight(10, context),
//              width: screenAwareWidth(240, context),
//              color: Colors.white,
//            ),
//            SizedBox(
//              height: screenAwareHeight(100, context),
//            ),
//            Text(
//              'Записывайтесь',
//              style: sloganStyle,
//            ),
//            Text(
//              'без очередей',
//              style: sloganStyle,
//            ),
//            Text(
//              'без проблем',
//              style: sloganStyle,
//            ),
//            Text(
//              'без потери времени',
//              style: sloganStyle,
//            ),
//          ],
//        ),
//      ),
//    );
//  }

  Widget _buildPhoneNumberInputField() {
    return SizedBox(
      width: screenAwareWidth(680, context),
      child: TextField(
        controller: _phoneValueController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: screenAwareHeight(55, context),          
          ),
          hintText: '(777) 777 77 77',
          
          filled: true,
          fillColor: Colors.white,

          prefixIcon: GestureDetector(
            child: Container(
              alignment: Alignment.center,
              width: screenAwareWidth(190.0, context),
        
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CountryPickerUtils.getDefaultFlagImage(_country),
                  ),
                  SizedBox(
                    width: screenAwareWidth(10, context),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      _countryCode,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenAwareHeight(55, context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: _openCountryPickerDialog,
          ),
        ),
        style: TextStyle(fontSize: screenAwareHeight(55, context)),
      ),
    );
  }
// webview dialog 
//  Widget openWebview() {
//     Navigator.of(context).push(new MaterialPageRoute<Null>(
//       builder: (BuildContext context) {
//         return Container(
//         child: WebviewScaffold(
//         url: "https:www.google.com/",
//         withZoom: true,
//         withLocalStorage: true,
//       ),
//     );

//             },
//             fullscreenDialog: false
//         ));
//   }

  Widget _buildCodeInputField() {    
    return Center(
      child: SizedBox(
        width: screenAwareWidth(500, context),        
        child: TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(14),
            WhitelistingTextInputFormatter.digitsOnly
          ],
          controller: _smsCodeValueController,
          textAlign: TextAlign.start,          
          keyboardType: TextInputType.number,      
          
          decoration: InputDecoration(
            hintText: 'X X X X X X',
            filled: true,
            fillColor: Colors.white,
            
          ),
          style: TextStyle(fontSize: screenAwareHeight(80, context)),
        ),
      ),
    );
  }


  Widget _buildCodeInputButtons() {
    return SizedBox(
      width: screenAwareWidth(480, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              height: screenAwareHeight(180, context),
              width: screenAwareWidth(180, context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,                
                color: AppColors.primaryAppColor,

                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   stops: _smsCodeSent ? [0] : AppColors.primaryButtonGradientStops,
                //   colors: _smsCodeSent ? [Colors.grey] : AppColors.confirmButtonGradientColors,
                // ),
              ),              
              child: FloatingActionButton(
                highlightElevation: 5,
              
                backgroundColor: _smsCodeSent ? Colors.grey : AppColors.primaryAppColor,
                elevation: 1,
                heroTag: "again",
                child: Icon(
                  Icons.refresh,
                  size: screenAwareHeight(100, context),
                ),
                onPressed: _smsCodeSent
                    ? null
                    : () => _pageController.animateToPage(0,
                        duration: Duration(milliseconds: 450),
                        curve: Curves.ease),
                        tooltip: "Повторить",
              )                
              ),          
          Container(
              height: screenAwareHeight(180, context),
              width: screenAwareWidth(180, context),              
              decoration: BoxDecoration(                
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: AppColors.primaryButtonGradientStops,
                  colors: AppColors.confirmButtonGradientColors,
                ),
              ),
              child: FloatingActionButton(                
                backgroundColor: AppColors.primaryAppColor,
                elevation: 1,                
                heroTag: "confirm",
                child: Icon(                  
                  Icons.keyboard_arrow_right,
                  size: screenAwareHeight(110, context),
                ),
                onPressed: () => _doLogin(),                
              )),           
        ],

      ),
    );
  }

  ////////////////////////////////////////////////////////////////////
  // UI Functions
  ////////////////////////////////////////////////////////////////////

  void _openCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (context) => Container(
            child: CountryPickerDialog(
              searchCursorColor: AppColors.primaryAppColor,
              searchInputDecoration: InputDecoration(
                hintText: 'Поиск...',
              ),
              isSearchable: true,
              onValuePicked: (Country country) => setState(() {
                    _country = country;
                    _countryCode = '+${country.phoneCode}';
                  }),
              title: Text(
                'Выберите страну',
              ),
              itemBuilder: (Country country) => Container(
                    child: Row(
                      children: <Widget>[
                        CountryPickerUtils.getDefaultFlagImage(country),
                        Text(
                          ' +${country.phoneCode} ${country.isoCode}',
                              style: TextStyle(
                              fontSize: screenAwareHeight(
                              37,context),
                              color: Theme.of(context).textTheme.body2.color),
                        ),
                      ],
                    ),
                  ),
            ),
          ),
    );
  }

  void _signOut(){
    FirebaseAuth.instance.signOut();
  }

  void _sendSms() {
    FocusScope.of(context).requestFocus(FocusNode());
    String formattedPhone = _phoneValueController.text.replaceAll(RegExp(r'\s\b|\b\s'), '');
    String phoneNumber = _countryCode + formattedPhone;

    print(phoneNumber + ' ' + phoneNumber.length.toString());

    if (phoneNumber.length < 14) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Введите действующий номер телефона'),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: phoneNumber,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 13.0
    );
      setState(() {
        _smsCodeSent = true;
      });

      _pageController.animateToPage(1,
          duration: Duration(milliseconds: 450), curve: Curves.easeInCubic);

      _startSmsTimer();

      bloc.sendCode(phoneNumber);
    }
  }

  void _doLogin() {

  //  _pageController.animateToPage(0,
  //         duration: Duration(milliseconds: 450), curve: Curves.ease);

    FocusScope.of(context).requestFocus(FocusNode());

    if (_smsCodeValueController.text.length < 6) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Пожалуйста введите код'),
        ),
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              Text("загрузка..."),
            ],
          ),
        ),
      );      
      
          Fluttertoast.showToast(
            msg: _smsCodeValueController.text,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 13.0
        );      
      bloc.signIn(_smsCodeValueController.text);


       Navigator.push(context,MaterialPageRoute(builder: (context) => ProfileData()));
    }
  }

  void _startSmsTimer() {
    if (mounted) {
      _timer = Timer.periodic(

        Duration(seconds: 1),
        (Timer timer) => setState(() {
            if (_smsCountdown < 1) {
                _smsCountdown = 50;
                _timer.cancel();
                setState(() {
                  _smsCodeSent = false;
                  
                  //_codeValueController = null;
                });

              } else {
                _smsCountdown = _smsCountdown - 1;
              }
            }),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_startSmsTimer();
    //_timer.cancel();    
    
  }
}
