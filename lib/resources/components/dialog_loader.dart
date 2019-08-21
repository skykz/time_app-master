import 'package:flutter/material.dart';
import 'package:time_app/utils/common_utils.dart';


class LoadingDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     child:AlertDialog(                    
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),      
      content: Container(
        constraints: const BoxConstraints(minWidth: 50.0),
        //width: screenAwareWidth(50, context),
        height: screenAwareHeight(200, context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          //  SizedBox(width: screenAwareWidth(70, context),),
          //   Text("Загрузка...",
          //     style: TextStyle(
          //       fontFamily: "OpenSans",
          //       color:  Color(0xFF5B6978),                
          //       ),
          //       textAlign: TextAlign.center,

          //     )
          ],          
          )
        )
     ),
    );
  }
}
