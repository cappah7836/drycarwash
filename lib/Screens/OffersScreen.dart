
import 'dart:async';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class OffersScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OffersScreenState();
  }
}

class OffersScreenState extends State<OffersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
  Stream<int>.periodic(Duration(seconds: 3), (x) => refreshNum);

  ScrollController? _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController();
    checkConnection();
    getSpecialOffers();
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    setState(() {
      refreshNum = new Random().nextInt(100);
      getSpecialOffers();
    });
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState!.show();
              })));
    });
  }
  var responseoffers;
  bool isLoading = true;

  getSpecialOffers() async {
    var dio = Dio();
    dio.options.baseUrl = "http://116.90.122.234:7777/api/";
    responseoffers = await dio.get("Sale/PackageList");
    if (responseoffers.statusCode == 200) {
      print(responseoffers.data);
      print(responseoffers.data[0]);

      setState(() {
        isLoading = false;
      });
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Server Not Responding",
          confirmBtnColor: Colors.red,
          barrierDismissible: false,
          animType: CoolAlertAnimType.slideInDown,
          backgroundColor: Colors.redAccent);
    }
  }
  checkConnection() async{
    var connection = await Connectivity().checkConnectivity();
    if(connection == ConnectivityResult.none){
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "No Internet Connection",
          confirmBtnColor: Colors.red,
          barrierDismissible: false,
          animType: CoolAlertAnimType.slideInDown,
          backgroundColor: Colors.redAccent);
    }
    else{
      setState(() {

      });
      print("Internet access he");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xff388E3C),
        title: Text("Special Offers"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
  body: isLoading == true
      ? Center(

    child: CircularProgressIndicator(),
  )
      : LiquidPullToRefresh(
    key: _refreshIndicatorKey,
    onRefresh: _handleRefresh,
    showChildOpacityTransition: false,
    child: StreamBuilder<int>(
    stream: counterStream,
    builder: (context, snapshot) {
    return Padding(
    padding: EdgeInsets.all(8),
    child: Column(
    children: [

    Expanded(
    child: ListView.builder(
    itemCount: responseoffers.data.length,
    itemBuilder: (context, index){
    return Card(
    color: Colors.white,
    elevation: 5,
    margin: EdgeInsets.all(5),
    child:Column(
    children: [
    SizedBox(
    height: 10,),
    Row(
    mainAxisAlignment:
    MainAxisAlignment.start,
    children: [
    SizedBox(
    width: 10,
    ),
    Flexible(
    child: Text(responseoffers.data[index]
    ['PackageName'].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
    ),
    ],
    ),
    SizedBox(
    height: 10,),
    Container(
    height: 1,
    color: Colors.grey[400],
    ),
    SizedBox(
    height: 10,),
    Padding(
    padding: EdgeInsets.only(top: 5),

    child: Column(

    children: [

    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
    mainAxisAlignment:
    MainAxisAlignment.spaceBetween,

    children: [

    Text(
    "Actual Amount",
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.redAccent,
    ),
    ),


    Text(
    responseoffers.data[index]
    ['Price'].toString(),
    style: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.redAccent,
    decoration: TextDecoration.lineThrough,
    ),
    ),


    ],
    ),
    ),
    SizedBox(height: 10,),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(

    mainAxisAlignment:
    MainAxisAlignment.spaceBetween,
    children: [
    Text(
    "Discounted Rate",
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.green,
    ),
    ),
    Text(
    responseoffers.data[index]
    ['Discounted_Rate'].toString(),
    style: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.green,

    ),
    ),
    ],
    ),
    ),
    ],
    ),


    ),
    SizedBox(
    height: 10,),

    ],
    ),

    );
    }


    ),
    ),
    ],


    ),
    );
    }),
  ),
    );
  }






}
