import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_app/screens/chat/chat_screen.dart';

import 'package:time_app/utils/common_utils.dart';
import 'package:time_app/resources/values/app_colors.dart';
import 'package:time_app/resources/components/primary_button.dart';
import 'package:time_app/bloc/home_bloc.dart';
import 'package:time_app/bloc/bloc_provider.dart';
import 'package:time_app/screens/specialists/specialists_screen.dart';

class HomeServicesTabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeServicesTabs();
  }
}

class _HomeServicesTabs extends State<HomeServicesTabs> with AutomaticKeepAliveClientMixin {
  HomeBloc _bloc;
  List<dynamic> _allServices = List();
  List<dynamic> _actualServices = List();

  @override
  void initState() {
    _bloc = BlocProvider.of<HomeBloc>(context);
    // _getActualServices();
    // _getAllServices();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
       preferredSize: Size.fromHeight(screenAwareHeight(125, context)),
       child:AppBar(        
        centerTitle: true,        
          title: SvgPicture.asset('assets/images/logo.svg',
            color: AppColors.primaryAppColor,
            height: screenAwareHeight(80, context),            
            width: screenAwareWidth(200, context),            
          ),
          
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset('assets/images/system_icons/chat_icon.svg'),
              onPressed: (){
                _goToChat();
              },
            )
           ],
          ),
       ),
      body:DefaultTabController(
      length: 2,
      child: ListView(
        children: <Widget>[
          Container(
            child: TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'АКТУАЛЬНЫЕ ',
                ),
                Tab(
                  text: 'ВСЕ УСЛУГИ',
                ),
              ],
            ),
          ),
          Container(
            height: screenAwareHeight(1200, context),
            child: TabBarView(children: <Widget>[
              _buildActualServices(),
              _buildAllServices()
            ]),
          )
        ],
      ),
    ),
    );
  }

  void _goToChat(){

    setState(() {});
      // if notification is exist
      //createing badges
      Navigator.push(context,MaterialPageRoute(builder: (context) => ChatScreen()));   
  }
  Widget _buildActualServices() {
    final double itemHeight = MediaQuery.of(context).size.height / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 1.1;

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return false;
      },
      child: GridView.count(
        padding: EdgeInsets.only(top: screenAwareHeight(50, context)),
        mainAxisSpacing: screenAwareHeight(80, context),
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisCount: 4,
        children: _servicesList(_actualServices),
      ),
    );
  }

  Widget _buildAllServices() {
    final double itemHeight = MediaQuery.of(context).size.height / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 1.1;

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return false;
      },
      child: GridView.count(
        padding: EdgeInsets.only(top: screenAwareHeight(50, context)),
        mainAxisSpacing: screenAwareHeight(80, context),
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisCount: 4,
        children: _servicesList(_allServices),
      ),
    );
  }

  List<Widget> _servicesList(List<dynamic> servicesList) {
    
    List<Widget> services = List();
    for (final service in servicesList) {
      services.add(
        Column(
          children: <Widget>[
            
            GestureDetector(
              onTap: () => _getServicesByType(service.state, service.type),
              child: Container(
                height: screenAwareHeight(220, context),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.grey,
                      width: screenAwareWidth(5, context)),
                ),
                child:SvgPicture.network(
                      'assets/images/system_icons/money.svg',
                      height: screenAwareHeight(80, context),
                      width: screenAwareWidth(80, context),
                ),
              ),
            ),
            Text(
              service.type,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: screenAwareHeight(28, context)),
            )
          ],
        ),
      );
    }

    return services;
  }

  _getAllServices() async {
    final response = await _bloc.getAllServices();

    setState(() {
      _allServices.addAll(response);
    });
  }

  _getActualServices() async {
    final response = await _bloc.getActualServices();

    setState(() {
      _actualServices.addAll(response);
    });
  }

  _getServicesByType(String serviceType, String serviceName) async {
    print('SERVICE TYPE: ' + serviceType);
    print('SERVICE NAME: ' + serviceName);

    final double itemHeight = MediaQuery.of(context).size.height / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 1.3;

    final response = await _bloc.getSubServices(serviceType);

    List<Widget> services = List();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              title: Text(
                serviceName,
              ),
              content: Container(
                height: screenAwareHeight(900, context),
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  mainAxisSpacing: screenAwareHeight(80, context),
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisCount: 4,
                  children: services,
                ),
              ));
        });

    for (final service in response) {
      services.add(
        Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                height: screenAwareHeight(160, context),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                    border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.grey,
                      width: screenAwareWidth(5, context)),
                ),
                child: _bloc.getNetworkImage(service.imgUrl, context),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  // bikeCode=99999999999 is done if user submitted feedback from the menu (not after ride). This is back-end problem and needs to be reviewed later
                  builder: (context) => SpecialistsScreen(),
                ),
              ),
            ),
            Text(
              service.type,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: screenAwareHeight(20, context)),
            )
          ],
        ),
      );
    }
  }



  @override
  bool get wantKeepAlive => true;
}

//Column(
//children: <Widget>[
//SvgPicture.network(
//_services[index].imgUrl,
//fit: BoxFit.cover,
//width: screenAwareWidth(180, context),
//height: screenAwareHeight(180, context),
//),
//Text(_services[index].type)
//],
//),

//Container(
//height: screenAwareHeight(1200, context),
//child: TabBarView(
//children: <Widget>[
//_buildAllServices(),

//),
//],
//),
//),
