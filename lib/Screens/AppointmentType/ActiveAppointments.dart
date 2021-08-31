import 'package:badges/badges.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class FirstScreen extends StatefulWidget {
  final int? uid;
  const FirstScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppointments();
  }

  bool isLoading = true;


  var responseoffers;


  getAppointments() async {
    var dio = Dio();

    dio.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "CustomerId": widget.uid});
    responseoffers = await dio.post("Sale/GetAppointmentList/", data: formData);
    print(responseoffers.data["obj"].length);
    if (responseoffers.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

    } else {
      print("Error...");
    }
  }

  var response;
  var id;

  cancelAppointment()async{
    var dio = Dio();
    dio.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "Id": id,  });
    response = await dio.post("Sale/CancelAppointmentById", data: formData);
    if (response.statusCode == 200) {
      print(response.data);

      var message = response.data['message'];


      if (message == "Appointemnt canceld successfully") {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Appointment cancelled successfully",
            autoCloseDuration: Duration(seconds: 2),
            confirmBtnColor: Theme.of(context).primaryColor,
            barrierDismissible: true,
            animType: CoolAlertAnimType.slideInRight,
            backgroundColor: Colors.green);

        getAppointments();
      }
      else if(message =="Appointemnt not exist"){
        final snackBar =
        SnackBar(content: Text('Appointment does not exists!'), backgroundColor: Colors.lightBlue);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
        final snackBar = SnackBar(
            content: Text('Server not responding!'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
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
                              "Your Booked Appointments", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                     ),
                       Expanded(
                         child: ListView.builder(
                                      itemCount: responseoffers.data["obj"].length,
                                      itemBuilder: (context, index) => Container(
                                        child: Card(
                                          color: Colors.white,
                                          elevation: 5,
                                          child:responseoffers.data["obj"][index]["isactive"].toString() == "true"
                                              ?Column(
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

                                                          child: Text(responseoffers.data["obj"][index]["day"].toString()+", " + " "+
                                                             responseoffers.data["obj"][index]["appointmenT_DATE"], style: TextStyle(fontWeight: FontWeight.bold),),
                                                        ),
                                                        Flexible(
                                                          child: Badge(
                                                            toAnimate: false,
                                                            shape: BadgeShape.square,
                                                            badgeColor: Colors.green,
                                                            borderRadius: BorderRadius.circular(8),
                                                            badgeContent: Text('ACTIVE', style: TextStyle(color: Colors.white)),
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
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      alignment: Alignment.centerRight,
                                                      // optional flex property if flex is 1 because the default flex is 1
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          id = responseoffers.data["obj"][index]['appointmenT_ID'].toString();
                                                          print(id);
                                                          cancelAppointment();
                                                        },
                                                        child: Text("CANCEL"),
                                                        style: ElevatedButton.styleFrom(primary: Colors.red),
                                                      ),

                                                    ),
                                                  ),
                                                ],
                                              )
                                              :Column()

                                        ),
                                      ),
                                    ),
                       ),

                    ],
                  ),
      ),
    );
  }
}
