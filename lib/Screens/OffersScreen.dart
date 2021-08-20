
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'DashboardScreen.dart';
class OffersScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OffersScreenState();
  }
}

class OffersScreenState extends State<OffersScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSpecialOffers();
/*    checkConnection();*/
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
  /*checkConnection() async{
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
      print("Internet access he");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      : Padding(
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
  ),
    );
  }






}
