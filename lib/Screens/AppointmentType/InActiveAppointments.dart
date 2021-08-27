import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final int? uid;
  const SecondScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}



class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // _foundUsers = _allUsers;
    super.initState();
    getAppointments();
  }

  // This function is called whenever the text field changes



  bool isLoading = true;


  var responseoffers;

  getAppointments() async {
    var dio = Dio();

    dio.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "CustomerId": widget.uid});
    responseoffers = await dio.post("Sale/GetAppointmentList/", data: formData);

    if (responseoffers.statusCode == 200) {

      setState(() {
        isLoading = false;
      });

    } else {
      print("Error...");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            Align(
                alignment: Alignment.center,
                child: Text(
                  "Your Canceled Appointments", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
            ),
            Expanded(
              child: ListView.builder(
                itemCount: responseoffers.data["obj"].length,
                itemBuilder: (context, index) => Card(
                  color: Colors.white,
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child:responseoffers.data["obj"][index]['cancel'].toString() ==
                      "true"
                      ? Column(

                    children: [
                      SizedBox(
                        height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Text(responseoffers.data["obj"][index]["day"].toString()+", " + " "
                                  +responseoffers.data["obj"][index]["appointmenT_DATE"], style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Flexible(
                              child: Badge(
                                toAnimate: false,
                                shape: BadgeShape.square,
                                badgeColor: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                                badgeContent: Text('CANCELED', style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
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
                            child: Text("From: "+responseoffers.data["obj"][index]["appointmenT_TIME"].toString()),
                          ),
                        ],
                      ),
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
                            child: Text(responseoffers.data["obj"][index]["packagE_NAME"].toString()),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                                responseoffers.data["obj"][index]["vehiclE_NO"] != "" ?  responseoffers.data["obj"][index]["vehiclE_NO"].toString(): "No vehicle number added"),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(responseoffers.data["obj"][index]["brancH_NAME"].toString()),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                                responseoffers.data["obj"][index]["address"] != "" ?  responseoffers.data["obj"][index]["address"].toString(): "No address added"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )  : Container(),




                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
