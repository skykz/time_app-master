import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:time_app/bloc/home_bloc.dart';
import 'package:time_app/screens/profile/profile_edit.dart';
import 'package:time_app/utils/common_utils.dart';
import 'package:time_app/bloc/bloc_provider.dart';

class ProfileScreen extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    final HomeBloc _bloc = BlocProvider.of<HomeBloc>(context); 
    return Scaffold(
      appBar: new AppBar(
              leading: new IconButton(
               icon: new Icon(Icons.arrow_back, color: Colors.black),
               onPressed: () =>Navigator.pop(context),
              ),
           iconTheme: IconThemeData(color: Colors.black),
           centerTitle: true,
           title: Text('Мой профиль',style: TextStyle(color: Colors.black)),
           actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){
                _goToEditProfile(context);
              },
            )
           ],              
      ),
      body: _buildProfilePage(context),

    );
  }

  _goToEditProfile(BuildContext context){

      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => ProfileEditMode()));   
  }

  Widget _buildProfilePage(BuildContext context){

    return Container(
       child: Column(    
        //padding: EdgeInsets.only(top: 30),
        children: <Widget>[   
         Container(                                               
              child: Row(
                children: <Widget>[

                  Column(
                    children: <Widget>[ 
                      Stack(                
                          children: <Widget>[                            
                             
                             IconButton(
                              padding: EdgeInsets.all(10.0),
                              iconSize: screenAwareHeight(320, context),                 
                              //icon: this._imageFile == null ? SvgPicture.asset('assets/images/users/default_avatar_users.svg')
                              icon: SvgPicture.asset('assets/images/users/default_avatar_users.svg'),
                              // :new CircleAvatar(backgroundImage: new FileImage(this._imageFile),radius: 200.0),
                              //onPressed: ()  => mainBottomSheet(context),
                              onPressed: (){},
                              tooltip: 'Your avatar',                              
                              ),                              
                              Container(
                                padding: EdgeInsets.only(left: 40,top: 100),                                
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: screenAwareWidth(155, context),
                                        height: screenAwareHeight(70, context),
                                        child: Row(
                                        children: <Widget>[
                                        SizedBox(width: screenAwareWidth(25, context)),
                                        SvgPicture.asset('assets/images/system_icons/rating.svg',height: screenAwareHeight(35, context)),
                                        SizedBox(width: screenAwareWidth(11, context)),
                                        Text("4.8",style: TextStyle(color: Colors.black))
                                        ],                                     
                                      ),
                                      decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(15.0), 
                                      color: Colors.white,                                      
                                      boxShadow:[ BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0,
                                      ),]
                                      ),
                                      ),
                                      
                                    ],
                                  ),
                                  
                              )

                          
                          ],
                      ),                  
                     
                                                                  
                    ],
                  ),
                  Column(                  
                    children: <Widget>[
                        //SizedBox(height: 20),
                      SizedBox(
                        width: screenAwareWidth(650, context),
                        height: screenAwareHeight(100, context),
                        child: Text("Анна Осипова",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenAwareHeight(48, context))),                          
                      ),
                      SizedBox(
                        width: screenAwareWidth(650, context),
                        height: screenAwareHeight(50, context),
                        child: Text("+7 778 446 78 34"),                          
                      ),
                      SizedBox(
                        width: screenAwareWidth(650, context),
                        child: Text("erasylgeso@gmail.com"),
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
                SizedBox(
                  height: screenAwareHeight(20, context),
                ),
                SizedBox(
                  width: screenAwareWidth(950, context),
                  child:Divider(
                    color: Colors.black87,
                ),
                ),

                SizedBox(                  
                      width: screenAwareWidth(1020, context),
                      child: Container(                        
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                child: Column(
                                  children: <Widget>[                               
                                    ListTile(
                                    leading: Icon(Icons.favorite_border),
                                    title: Text(" Избранные "),
                                    onTap: (){
                                     // Navigator.pop(context);
                                      //action();
                                    },
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),                               
                                    ListTile(
                                    leading: Icon(Icons.settings),
                                    title: Text(" Служба поддержки "),
                                    onTap: (){
                                     // Navigator.pop(context);
                                      //action();
                                    },
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                 
                                    ListTile(
                                    leading: Icon(Icons.event_note),
                                    title: Text(" Новости "),
                                    onTap: (){
                                      //Navigator.pop(context);
                                      //action();
                                    },
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                  ],
                                ),
                              ),
                            )                        
                          ],
                        ),
                      ),
                    ),                
                ],
              ),                                    
            ],
        ),
        ]
       ),
      );
  }
}
