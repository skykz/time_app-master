import 'dart:io';
//import 'dart:io' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_app/resources/values/app_colors.dart';
import 'package:time_app/screens/home/home_screen.dart';
import 'package:time_app/utils/common_utils.dart';
import 'package:image_picker/image_picker.dart';

//import 'image_pi';

class ProfileData extends StatefulWidget {
  const ProfileData({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFormFieldExampleState();
}

class _TextFormFieldExampleState extends State<ProfileData> {

  //final GlobalKey<FormFieldState<String>> _passwordFieldKey = new GlobalKey<FormFieldState<String>>();
  //PageController _pageController = PageController(initialPage: 0);

  String _name;
  String _phoneNumber;
  String _email;
  
  // to pick image 
  File _imageFile;
  
 @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false, // added this but i don't know what is it
      
      appBar: new AppBar(        
        iconTheme: IconThemeData(color: Colors.black87),
        title: const Text('Профиль',style: TextStyle(color: AppColors.primaryBodyTextColor)),
        actions: <Widget>[
          FlatButton(
            color: Colors.transparent,
            textColor: AppColors.primaryAppColor,
            disabledColor: Colors.grey,            
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.greenAccent[70],
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

            onPressed: () { 
              /*...*/
            },
            child: 
            GestureDetector(child: Text(
              "Готово ",              
              style: TextStyle(fontSize: 18.0),                                          
            ),                 
            onTap:() => goHome(),
            ),
          ),
        ],
      ),
     
      body: Container(
       child: Column(    
        //padding: EdgeInsets.only(top: 30),
        children: <Widget>[   
         Container(                                               
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[                   
                      IconButton(
                      padding: EdgeInsets.all(10.0),
                      iconSize: screenAwareHeight(320, context),                 
                      icon: this._imageFile == null ? SvgPicture.asset('assets/images/users/default_avatar_users.svg')
                      :new CircleAvatar(backgroundImage: new FileImage(this._imageFile),radius: 200.0),
                      onPressed: ()  => mainBottomSheet(context),
                      tooltip: 'Upload your avatar',
                        ),                                        
                    ],
                  ),
                  Column(                  
                    children: <Widget>[
                        //SizedBox(height: 20),
                      SizedBox(
                        width: screenAwareWidth(650, context),
                        child: TextFormField(                    
                        decoration: const InputDecoration(                      
                          border: UnderlineInputBorder(),                                                                                                      
                          hintText: 'Ваше имя?',
                          labelText: 'Имя *',
                          //prefixText: '+86',
                        ),
                        keyboardType: TextInputType.text,
                        onSaved: (String value) {
                          this._phoneNumber = value;
                        },                        
                      ),
                      ),
                      SizedBox(
                        width: screenAwareWidth(650, context),
                        child:TextFormField(
                          textCapitalization: TextCapitalization.words,            
                          decoration: InputDecoration(
                          border: UnderlineInputBorder(),                          

                          hintText: 'Ваша фамилия?',
                          labelText: 'Фамилия *',
                        ),
                            onSaved: (String value) {
                            this._name = value;
                          },
                          // validator: _validateName,
                          ),             
                      ),
                                                               
                    ],
                  ),                                                     
                ],                
              ),                               
        ),
                Column(
                  children: <Widget>[            
                    Column(
                     children: <Widget>[
                        Text(                  
                            'Укажите имя и фамилию, добавьте фотографию для Вашего профиля.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            color: Colors.black54,
                            fontSize: screenAwareHeight(30, context),                      
                            ),            
                          ),
                          SizedBox(
                              width: screenAwareWidth(1020, context),
                              child: TextFormField(
                              decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.email),
                              hintText: 'Ваш email адрес',
                              labelText: 'E-mail',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String value) {
                            this._email = value;
                            },
                          ),
                        ),                  
                    ],
                )                                    
            ],
           )                            
        ],
        ),
      ),
    );

  }     

    mainBottomSheet(BuildContext context){
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context){
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[               
                _createTile(context, 'Камера', Icons.camera_alt, _actionCamera),
                _createTile(context, 'Галлерея', Icons.photo_library, _actionGallery),
              ],
            );
          }
      );
    }


      ListTile _createTile(BuildContext context, String name, IconData icon, Function action){
        return ListTile(
          leading: Icon(icon),
          title: Text(name),
          onTap: (){
            Navigator.pop(context);
            action();
          },
        );
      }

     Future <Null> _actionCamera() async {
       final File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

       setState(() => this._imageFile = imageFile);         
     }

    Future <Null> _actionGallery() async {
       final File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

       setState(() => this._imageFile = imageFile);         
     }

    void goHome(){

             Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
    }

  }

  // Future<Null> _pickImageFromGallery() async{

  //   final File imageFile = await ImagePicker.pickImage(source:ImageSource.gallery);
  //   setState(() => this._imageFile = imageFile);
  // }
    
  