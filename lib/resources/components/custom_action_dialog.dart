import 'package:flutter/material.dart';


import 'package:time_app/utils/common_utils.dart';
import 'package:time_app/resources/values/app_colors.dart';
import 'package:time_app/resources/values/app_dimensions.dart';

class CustomActionDialog extends StatelessWidget {
  final String title;
  final Function onPressed;
  final String cancelOptionText;
  final String confirmOptionText;

  CustomActionDialog({@required this.title, @required  this.onPressed, @required this.cancelOptionText, @required this.confirmOptionText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.actionDialogRadius)),  
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: screenAwareHeight(44, context),
            color: Theme.of(context).textTheme.body2.color),
            textAlign: TextAlign.center,),

            content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                splashColor: AppColors.positiveOptionColor,                        
                child: Text(
                  cancelOptionText,              
                  style: TextStyle(
                      fontSize: screenAwareHeight(45, context),
                      color: Colors.green,fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                splashColor: AppColors.negativeOptionColor,
                 
                child: Text(
                  confirmOptionText,
                  style: TextStyle(
                      fontSize: screenAwareHeight(45, context),
                      color: Colors.red,fontWeight: FontWeight.bold),
                ),
                onPressed: onPressed,
              ),
            ],
      ),

    );
  }
}

class CustomActionDialogChoose extends StatelessWidget {
  final String title;
  final Function onPressed;
  final String cancelOptionText;
  final String confirmOptionText;

  CustomActionDialogChoose({@required this.title, this.onPressed, @required this.cancelOptionText, @required this.confirmOptionText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.actionDialogRadius)),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: screenAwareHeight(44, context),
            color: Theme.of(context).textTheme.body2.color),
            textAlign: TextAlign.center,),
            content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                splashColor: Colors.redAccent[80],                        
                child: Text(
                  cancelOptionText,              
                  style: TextStyle(
                      fontSize: screenAwareHeight(40, context),
                      color: Colors.green,fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                splashColor: Colors.greenAccent[75],
                child: Text(
                  confirmOptionText,
                  style: TextStyle(
                      fontSize: screenAwareHeight(40, context),
                      color: Colors.red,fontWeight: FontWeight.bold),
                ),
                onPressed: onPressed,
              ),
            ],
      ),

    );
  }
}