import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:time_app/utils/common_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_app/bloc/bloc_provider.dart';
import 'package:time_app/data/network/repository/time_api.dart';

class HomeBloc implements BlocBase {

  TimeAPI _api = TimeAPI();

  final _servicesListController = StreamController<List<dynamic>>();


  Stream<List<dynamic>> get servicesList => _servicesListController.stream.asBroadcastStream();


  void signOut() async {
    FirebaseAuth.instance.signOut();
  }

  Future<List<dynamic>> getAllServices() async {
    return await _api.getAllServices();
  }

  Future<List<dynamic>> getActualServices() async {
    return await _api.getActualServices();
  }

  Future<List<dynamic>> getSubServices(String serviceType) async {
    return await _api.getSubServicesByType(serviceType);
  }

  SvgPicture getNetworkImage(String url, BuildContext context) {

    try {
      return SvgPicture.network(
        url,
        height: screenAwareHeight(80, context),
        width: screenAwareWidth(80, context),
      );
    } catch(error) {
      print('===================================== FAILED TO RETREIVE IMAGE FROM NETWORK: ' + error.toString());

      return SvgPicture.asset(
        'assets/images/logo.svg',
        height: screenAwareHeight(80, context),
        width: screenAwareWidth(80, context),
      );
    }
  }



  @override
  void dispose() {
    _servicesListController.close();
  }
}