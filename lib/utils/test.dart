// aimport 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:time_app/resources/values/app_colors.dart';
// import 'package:time_app/utils/common_utils.dart';
// //import 'image_pi';

// class ProfileData extends StatefulWidget {
//   const ProfileData({Key key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _TextFormFieldExampleState();
// }

// class _TextFormFieldExampleState extends State<ProfileData> {
//   final GlobalKey<FormFieldState<String>> _passwordFieldKey =
//       new GlobalKey<FormFieldState<String>>();
//   PageController _pageController = PageController(initialPage: 0);

//   String _name;
//   String _phoneNumber;
//   String _email;
  
//   // to pick image 
//   File _imageFile;
  
//  @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       resizeToAvoidBottomPadding: false, // added this but i don't know what is it
      
//       appBar: new AppBar(        
//         iconTheme: IconThemeData(color: AppColors.primaryAppColor),
//         title: const Text('Профиль',style: TextStyle(color: AppColors.primaryBodyTextColor)),
//         actions: <Widget>[
//           FlatButton(
//             color: Colors.transparent,
//             textColor: AppColors.primaryAppColor,
//             disabledColor: Colors.grey,            
//             disabledTextColor: Colors.black,
//             padding: EdgeInsets.all(8.0),
//             splashColor: Colors.greenAccent[70],
//             shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

//             onPressed: () {
//               /*...*/
//             },
//             child: Text(
//               "Готово ",              
//               style: TextStyle(fontSize: 15.0),
//             ),            
//           ),
//         ],
//       ),
      
//       body: Container(

//       // width: screenAwareWidth(1070, context),
//       child: Text("data"),

        
//   }
//   }

//       // margin: const EdgeInsets.only(top: 50.0),        
//       // padding: const EdgeInsets.symmetric(horizontal: 10.0),           
//         // child: Row(
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   crossAxisAlignment: CrossAxisAlignment.center,
//         //     children: <Widget>[
//         //       //  Padding(padding: EdgeInsets.only(top: 350)),            
//         //       Column(                
//         //         children: <Widget>[
//         //           IconButton(
//         //           iconSize: 200,                 
//         //           icon: SvgPicture.asset('assets/images/users/default_avatar.svg'), 
//         //           onPressed: () {
//         //             // pick image from camera or gallery
//         //           },
//         //           ),                                        
//         //         ],
//         //       ),

//             // Column(                          
//             //   children: <Widget>[                
//             //     SizedBox(height: 20),
//             //     TextFormField(
//             //       textCapitalization: TextCapitalization.words,            
//             //       decoration: InputDecoration(
//             //       border: UnderlineInputBorder(),
//             //       filled: true,
//             //       icon: Icon(Icons.person),
//             //       hintText: 'Ваше имя?',
//             //       labelText: 'Имя *',
//             //     ),
//             //         onSaved: (String value) {
//             //         this._name = value;
//             //       },
//             //       validator: _validateName,
//             //       ),             
//             //        SizedBox(height: 24.0),
//             //       // "Phone number" form.
//             //       TextFormField(                    
//             //         decoration: const InputDecoration(                      
//             //           border: UnderlineInputBorder(),
//             //           filled: true,
//             //           icon: Icon(Icons.account_circle),
//             //           hintText: 'Ваша фамилия?',
//             //           labelText: 'Фамилия *',
//             //           //prefixText: '+86',
//             //         ),
//             //         keyboardType: TextInputType.text,
//             //         onSaved: (String value) {
//             //           this._phoneNumber = value;
//             //         },
//             //         // TextInputFormatters are applied in sequence.
//             //         inputFormatters: <TextInputFormatter>[
//             //           WhitelistingTextInputFormatter.digitsOnly,
//             //         ],
//             //       ),
//             //        ],          
//             // ),                                       

//         //  children: <Widget>[
//         //     Padding(
//         //       padding: EdgeInsets.only(right: 300),           
//         //       child: IconButton(
//         //         iconSize: screenAwareHeight(300, context),                 
//         //         icon: SvgPicture.asset('assets/images/users/default_avatar.svg',height: 200.0,width: 200.0), 
//         //         onPressed: () {},
//         //         ),          
//         //         //SvgPicture.asset('assets/images/users/default_avatar.svg',height: 100.0,width: 100.0)),              
//         //       ),
//         //   SizedBox(height: screenAwareHeight(50, context)),
//         //   // "Name" form.
//         //   TextFormField(
//         //     textCapitalization: TextCapitalization.words,            
//         //     decoration: InputDecoration(
//         //       border: UnderlineInputBorder(),
//         //       filled: true,
//         //       icon: Icon(Icons.person),
//         //       hintText: 'Ваше имя?',
//         //       labelText: 'Имя *',
//         //     ),
//         //     onSaved: (String value) {
//         //       this._name = value;
//         //     },
//         //     validator: _validateName,
//         //   ),
//         //   SizedBox(height: 24.0),
//         //   // "Phone number" form.
//         //   TextFormField(
//         //     decoration: const InputDecoration(
//         //       border: UnderlineInputBorder(),
//         //       filled: true,
//         //       icon: Icon(Icons.account_circle),
//         //       hintText: 'Ваша фамилия?',
//         //       labelText: 'Фамилия *',
//         //       //prefixText: '+86',
//         //     ),
//         //     keyboardType: TextInputType.text,
//         //     onSaved: (String value) {
//         //       this._phoneNumber = value;
//         //     },
//         //     // TextInputFormatters are applied in sequence.
//         //     inputFormatters: <TextInputFormatter>[
//         //       WhitelistingTextInputFormatter.digitsOnly,
//         //     ],
//         //   ),
//         //   SizedBox(height: 24.0),
//         //   // "Email" form.
//         //   TextFormField(
//         //     decoration: const InputDecoration(
//         //       border: UnderlineInputBorder(),
//         //       filled: true,
//         //       icon: Icon(Icons.email),
//         //       hintText: 'Ваш email адрес',
//         //       labelText: 'E-mail',
//         //     ),
//         //     keyboardType: TextInputType.emailAddress,
//         //     onSaved: (String value) {
//         //       this._email = value;
//         //     },
//         //   ),
//         //   SizedBox(height: 24.0),
//         // ],   



//   String _validateName(String value) {
//     if (value.isEmpty) return 'Name is required.';

//     final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');

//     if (!nameExp.hasMatch(value))
//       return 'Please enter only alphabetical characters.';

//     return null;
//   }
//   }

//   // Future<Null> _pickImageFromGallery() async{

//   //   final File imageFile = await ImagePicker.pickImage(source:ImageSource.gallery);
//   //   setState(() => this._imageFile = imageFile);
//   // }
    
// class PasswordField extends StatefulWidget {
//   const PasswordField({
//     this.fieldKey,
//     this.hintText,
//     this.labelText,
//     this.helperText,
//     this.onSaved,
//     this.validator,
//     this.onFieldSubmitted,
//   });

//   final Key fieldKey;
//   final String hintText;
//   final String labelText;
//   final String helperText;
//   final FormFieldSetter<String> onSaved;
//   final FormFieldValidator<String> validator;
//   final ValueChanged<String> onFieldSubmitted;

//   @override
//   _PasswordFieldState createState() => new _PasswordFieldState();
// }

// class _PasswordFieldState extends State<PasswordField> {
//   bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return new TextFormField(
//       key: widget.fieldKey,
//       obscureText: _obscureText,
//       maxLength: 8,
//       onSaved: widget.onSaved,
//       validator: widget.validator,
//       onFieldSubmitted: widget.onFieldSubmitted,
//       decoration: new InputDecoration(
//         border: const UnderlineInputBorder(),
//         filled: true,
//         hintText: widget.hintText,
//         labelText: widget.labelText,
//         helperText: widget.helperText,
//         suffixIcon: new GestureDetector(
//           onTap: () {
//             setState(() {
//               _obscureText = !_obscureText;
//             });
//           },
//           child:
//               new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
//         ),
//       ),
//     );
//   }
// }
 

//   //     body: SizedBox(
//   //         child: Container(
//   //             margin: const EdgeInsets.only(top: 25.0),
//   //                 height: screenAwareHeight(1080.0, context),
//   //                    child: Row(                    
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                      children: <Widget>[                          
//   //                          new SvgPicture.asset('assets/images/users/default_avatar.svg',width: 100.0,height: 100.0),                            
//   //                           new Expanded(
//   //                             child: new Container(
//   //                               padding: new EdgeInsets.all(10.0),
//   //                               child: new Column(
//   //                                 children: <Widget>[
//   //                                   new TextField(        
//   //                                     textAlign: TextAlign.start,
//   //                                     keyboardType: TextInputType.text,                                    
//   //                                     decoration: InputDecoration(
//   //                                       hintText: 'Ваше имя',
//   //                                       filled: false,
//   //                                       fillColor: Colors.white,                                      
//   //                                     ),
//   //                                     style: TextStyle(fontSize: screenAwareHeight(55, context)),
//   //                                   ),  
//   //                                   new TextField(        
//   //                                     textAlign: TextAlign.start,
//   //                                     keyboardType: TextInputType.text,                                                                          
//   //                                     decoration: InputDecoration(
//   //                                       hintText: 'Фамилия',
//   //                                       filled: false,
//   //                                       fillColor: Colors.white,                                
//   //                                     ),
//   //                                     style: TextStyle(fontSize: screenAwareHeight(55, context)),
//   //                                   ),
                                                                       
//   //                                 ],                                
//   //                               ),
//   //                             ),                                                              
//   //                           ), 
//   //                           new Expanded(
//   //                             child: new Container(

//   //                             ),
//   //                           ),                                                                           
//   //                           //  new Container(
//   //                           //     height: screenAwareHeight(140, context),

//   //                           //    child: SizedBox(
//   //                           //             child: new Column(
//   //                           //               children: <Widget>[
//   //                           //                 new Text('Укажите имя и фамалию, добавьте фотографию для Вашего профиля.'),
//   //                           //                 new TextFormField(
//   //                           //                   decoration: const InputDecoration(
//   //                           //                     icon: const Icon(Icons.calendar_today),
//   //                           //                     hintText: 'Введите почту',
//   //                           //                     labelText: 'email почта',
//   //                           //                   ),
//   //                           //                   keyboardType: TextInputType.datetime,
//   //                           //                 ),
//   //                           //               ],
//   //                           //             )
//   //                           //           ),
//   //                           //   ),                          
//   //                         ], 
                                                                                                                                                                             
//   //                     ),                                                                           
//   //                   ),                                                        
//   //                 ),                           
//   //   );
//   // }

  
//   // Widget _profileBody(){

//   //     return Container(        
//   //       width: screenAwareWidth(474, context),  
//   //       child: SizedBox(
//   //         child: Row(     
//   //          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //           children: <Widget>[
//   //             TextField(
//   //             inputFormatters: [
//   //               LengthLimitingTextInputFormatter(6)
//   //             ],
//   //             controller: TextEditingController(),
//   //             textAlign: TextAlign.start,
//   //             keyboardType: TextInputType.number,      
              
//   //             decoration: InputDecoration(
//   //               hintText: 'Ваше имя',
//   //               filled: true,
//   //               fillColor: Colors.white,
                
//   //             ),
//   //             // style: TextStyle(fontSize: screenAwareHeight(75, context)),
//   //           ),   
//   //           TextField(             
//   //             controller: TextEditingController(),
//   //             textAlign: TextAlign.start,
//   //             keyboardType: TextInputType.number,      
              
//   //             decoration: InputDecoration(
//   //               hintText: 'Ваше имя',
//   //               filled: true,
//   //               fillColor: Colors.white,
                
//   //             ),
//   //             style: TextStyle(fontSize: screenAwareHeight(75, context)),
//   //           ),   
//   //       ],     
//   //     ),  

//   //       ),
      
//   //     );
//   // }
//         // color: Colors.grey,
//         // child: new Row(        
//         //   children: <Widget>[
//         //     new Expanded(child: 
//         //     new Container(
//         //       padding: new EdgeInsets.all(3.0),
//         //       child: new Column(children: <Widget>[
//         //           new EditableText(
//         //                       controller: TextEditingController(),
//         //                       cursorColor: AppColors.primaryAppColor,
//         //                       backgroundCursorColor: Colors.white,
//         //                       textDirection: TextDirection.ltr,
//         //                       cursorOpacityAnimates: true,
//         //                       showCursor: true,                        
//         //                       focusNode: FocusNode(),
//         //                       style: TextStyle(fontSize: 20,color: Colors.black),
//         //                   ),
//         //     ],),),),
           
//             //  Container(child:new Column(children: <Widget>[        
//             //   new EditableText(                
//             //     autocorrect: true,
//             //     backgroundCursorColor: AppColors.primaryAppColor,
//             //     autofocus: true,
//             //     textAlign: TextAlign.start,
//             //     style: TextStyle(color: Colors.black,fontSize: 18.0),
//             //     keyboardType: TextInputType.text,
//             //     cursorColor: AppColors.primaryAppColor, controller: TextEditingController(), focusNode: FocusNode(),
//             //   ),
//             // ],),)                               

//     //   final leftColumn = Container(
//     //   padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
//     //   child: Column(
//     //     children: [ 
//     //       ratings,
//     //       iconList,
//     //     ],
//     //   ),
//     // );

//   // Widget _buildProfilePage(BuildContext context){

//   //        return Center(
//   //          child: Container(
//   //           //  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//   //            height: screenAwareHeight(25, context),
//   //            child: Card(
//   //              child: Row(
//   //                children: <Widget>[
//   //                  Container(
//   //                    width: screenAwareHeight(10, context),
//   //                    child: ,
//   //                  ),
//   //                ],
//   //              ),
//   //            ),              
//   //           ),
//   //        );  
//   //   }
