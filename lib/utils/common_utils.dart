import 'package:flutter/material.dart';
import 'package:time_app/resources/components/dialog_loader.dart';
import 'dart:io';

import 'package:time_app/resources/values/app_dimensions.dart';
import 'package:time_app/resources/components/custom_action_dialog.dart';


double screenAwareHeight(double height, BuildContext context) {
  return height * MediaQuery.of(context).size.height / AppDimensions.baseHeight;
}

double screenAwareWidth(double width, BuildContext context) {
  return width * MediaQuery.of(context).size.width / AppDimensions.baseWidth;
}

Future<bool> exitApp(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) =>
        CustomActionDialog(
            title: 'Вы действительно хотите выйти из приложения?',
            onPressed: () => exit(0),
          cancelOptionText: 'Нет',
          confirmOptionText: 'Да',
        ),
  );
}

Future<bool> choosingWindowYesOrNo(BuildContext context,String _text,String _optionPostitive,String _optionNegative,Function dofunc) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) =>
        CustomActionDialogChoose(
            title: _text,       
            onPressed: () => dofunc(), 
            cancelOptionText: _optionNegative,
            confirmOptionText: _optionPostitive,
        ),
  );
}

Future<bool> loadingProcess(BuildContext context){
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => 
      LoadingDialog(      
      ),
  );
}