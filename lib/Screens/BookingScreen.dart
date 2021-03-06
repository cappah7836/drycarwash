import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:drycarwash/Models/PackageModel.dart';
import 'package:drycarwash/Models/ServiceModel.dart';
import 'package:drycarwash/Models/VehicleModel.dart';
import 'package:drycarwash/Screens/AppointmentScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BookingScreenState();
  }
}

class BookingScreenState extends State<BookingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? _type = "Service Station";
  int? uid;
  bool isLoading = true;
  ///////////////////////////////////////////////////////
  getUserId()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    uid = pref.getInt("userid")?? 0;
    print(uid);


  }


  @override
  void initState() {
    // TODO: implement initState
    // _foundUsers = _allUsers;
    super.initState();
    getUserId();
    checkConnection();

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
    else if(connection == ConnectivityResult.wifi){

      isDisabled = false;
      getTimeSlot();
      print("Internet access he");
    }
    else{
      print("Meri galtion ka galat istamal");
    }
  }
  /*Upload Data to Server*/
  var response;
  SendAppointment() async {
    var day = dayFormat.format(selectedDate);
    var date = dateFormat.format(selectedDate);
    var dioRequest = Dio();
    dioRequest.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "PACKAGE_ID": ex1?.pID,
      "VEHICLE_ID": ex4?.id,
      "CUSTOMER_ID": uid,
      "APPOINTMENT_TIME":val,
      "APPOINTMENT_DATE":date,
      "DAY":day,
      "COMPANY_ID":"1",
      "BRANCH_ID": ex2?.Branch_id,
      "TYPE": _type,
      "ADDRESS": address.text,
      "VEHICLE_NO": vehicleno.text,
      "NOTE": remarks.text,


    });
    print(uid);
    print(ex1?.pID);
    print(ex4?.id);
    print(ex2?.Branch_id);
    print(_type);
    print(vehicleno.text);
    print(remarks.text);
    print(address.text);
    print(date);
    print(val);
    print(day);

    response = await dioRequest.post("Sale/AddAppointment", data: formData);

    if (response.statusCode == 200) {
      print(response.data);

      var message = response.data['message'];


      if (message == "Appointemnt added successfully") {
        setState(() {
          Navigator.pop(context);
        });
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Appointment booked successfully",
            autoCloseDuration: Duration(seconds: 3),
            confirmBtnColor: Theme.of(context).primaryColor,
            barrierDismissible: true,
            animType: CoolAlertAnimType.slideInRight,
            backgroundColor: Colors.green);
        vehicleno.text ="";
        val="Time slot";
        remarks.text="";
        address.text="";
        ex2?.Branch_name ="Choose Service Center";
        ex4?.name ="Vehicle";
        ex1?.pName ="Package";
        if (ex1?.pName == ex1?.pName) {
          setState((){
            Visible = false;
          });
        }

      } else if(message == "Appointemnt Exist for selected Time chose another Time!") {
        setState(() {
          Navigator.pop(context);
        });
        final snackBar =
        SnackBar(content: Text('Please select other time slot it has a booking'), backgroundColor: Colors.blueAccent);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      else if (message == "Please enter complete Info!") {
        setState(() {
          Navigator.pop(context);
        });
        final snackBar =
        SnackBar(content: Text('Alert!, Please enter complete info!'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      else {
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
    else if(response.statusCode == 500){
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Server Not Responding",
          confirmBtnColor: Colors.red,
          barrierDismissible: false,
          animType: CoolAlertAnimType.slideInDown,
          backgroundColor: Colors.redAccent);
    }
    else {
      print("Error...");
    }
  }

  DateTime selectedDate = DateTime.now();
  final dayFormat = DateFormat('EEEE');
  final dateFormat = DateFormat.yMMMMd('en_US');
  final GlobalKey<FormState> _formKey = GlobalKey();
  /*Searchable Model*/
  ////////////////////////////////////////////////////
  PackageModel? ex1;
  ServiceModel? ex2;
  VehicleModel? ex4;
  ////////////////////////////////////////////////////////////
  bool isVisible = false;
  bool Visible = false;
  bool isDisabled = true;
  bool date = false;
  bool time = false;
  bool package = false;
  bool vehicle = false;
  bool service = false;

  String vehiclename="Vehicle";
  String timename = "Time Slot";
  String servicecenter = "Choose Service Center";
  String packagename = "Package";



  var response2;
  int number = 0;
  TextEditingController txt= new TextEditingController();

  getTimeSlot() async {
    var dio = Dio();
    dio.options.baseUrl = "http://116.90.122.234:7777/api/";
    response2 = await dio.get("Sale/CalendarList");
    if (response2.statusCode == 200) {

      setState(() {
        isDisabled = false;
      });


    } else if(response2.data == null) {
      final snackBar =
      SnackBar(content: Text('Server Not Responding!'), backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
      print("Error");
    }
  }

  final TextEditingController vehicleno = TextEditingController();
  final TextEditingController remarks = TextEditingController();
  final TextEditingController address = TextEditingController();


  String? val;
  getDay(){
    getTimeSlot();
    if(selectedDate.weekday == 1){
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return  AlertDialog(
              title: Text('Select Time Slot'),
              content: Container(
                width: double.minPositive,
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: response2.data.length=28,
                  itemBuilder: (BuildContext context, int index) {
                    return isLoading == true
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListTile(
                      title: Text(response2.data[0]["AVAILABLE_DAY_TIME"][index].toString()),
                      onTap: () {
                        setState(() {
                          val = response2.data[0]["AVAILABLE_DAY_TIME"][index].toString();
                          Navigator.pop(context);
                        });
                      },
                    );
                  },
                ),
              ),
            );
          });
    }
    else if(selectedDate.weekday == 2){
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Time Slot'),
              content: Container(
                width: double.minPositive,
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: response2.data.length=28,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(response2.data[1]["AVAILABLE_DAY_TIME"][index].toString()),
                      onTap: () {
                        setState(() {
                          val = response2.data[1]["AVAILABLE_DAY_TIME"][index].toString();
                          Navigator.pop(context);
                        });
                      },

                    );
                  },
                ),
              ),
            );
          });

    }
    else if(selectedDate.weekday == 3){
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Time Slot'),
              content: Container(
                width: double.minPositive,
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: response2.data.length=26,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(response2.data[2]["AVAILABLE_DAY_TIME"][index].toString()),
                      onTap: () {
                        setState(() {
                          val = response2.data[2]["AVAILABLE_DAY_TIME"][index].toString();
                          Navigator.pop(context);
                        });
                      },
                    );
                  },
                ),
              ),
            );
          });
    }
    else if(selectedDate.weekday == 4){
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Time Slot'),
              content: Container(
                width: double.minPositive,
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: response2.data.length=28,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(response2.data[3]["AVAILABLE_DAY_TIME"][index].toString()),
                      onTap: () {
                        setState(() {
                          val = response2.data[3]["AVAILABLE_DAY_TIME"][index].toString();
                          Navigator.pop(context);
                        });
                      },
                    );
                  },
                ),
              ),
            );
          });
    }
    else if(selectedDate.weekday == 5){
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Time Slot'),
              content: Container(
                width: double.minPositive,
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: response2.data.length=28,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(response2.data[4]["AVAILABLE_DAY_TIME"][index].toString()),
                      onTap: () {
                        setState(() {
                          val = response2.data[4]["AVAILABLE_DAY_TIME"][index].toString();
                          Navigator.pop(context);
                        });
                      },
                    );
                  },
                ),
              ),
            );
          });
    }
    else if(selectedDate.weekday == 6){
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Time Slot'),
              content: Container(
                width: double.minPositive,
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: response2.data.length=28,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(response2.data[5]["AVAILABLE_DAY_TIME"][index].toString()),
                      onTap: () {
                        setState(() {
                          val = response2.data[5]["AVAILABLE_DAY_TIME"][index].toString();
                          Navigator.pop(context);
                        });
                      },
                    );
                  },
                ),
              ),
            );
          });
    }
    else if(selectedDate.weekday == 7){
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Time Slot'),
              content: Container(
                width: double.minPositive,
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: response2.data.length=28,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(response2.data[6]["AVAILABLE_DAY_TIME"][index].toString()),
                      onTap: () {
                        setState(() {
                          val = response2.data[6]["AVAILABLE_DAY_TIME"][index].toString();
                          Navigator.pop(context);
                        });
                      },
                    );
                  },
                ),
              ),
            );
          });
    }
    else{
      print("ERROR");
    }

  }
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff388E3C),
        title: Text("Book Appointment"),
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


      body:Padding(
          padding: MediaQuery.of(context).viewInsets,
        child: RefreshIndicator(
              onRefresh: () async{
                await Future.delayed(Duration(seconds: 2));
                setState(() {
                  checkConnection();
                });
                print("Refresh Pressed");
                return null;
              },
              child: Container(
                child:SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Book your appointment", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                              )
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: ListTile(
                                      title: const Text('Service Station',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                      horizontalTitleGap: 0,
                                      leading: Radio<String>(
                                        value: "Service Station",
                                        groupValue: _type,
                                        onChanged: (String? value) {
                                          setState(() {
                                            if (value == "Service Station") {
                                              setState((){
                                                isVisible = false;
                                              });
                                            } else {
                                              setState(() {
                                                isVisible = true;
                                              });
                                            }
                                            _type = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: const Text('Home',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                                      horizontalTitleGap: 0,
                                      leading: Radio<String>(
                                        value: "Home",
                                        groupValue: _type,
                                        onChanged: (String? value) {
                                          if (value == "Home") {
                                            setState((){
                                              isVisible = true;
                                            });
                                          } else {
                                            setState(() {
                                              isVisible = false;
                                            });
                                          }
                                          setState(() {
                                            _type = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                          Visibility(
                            visible: isVisible,
                            child: Container(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[

                                  SizedBox(height: 10.0),

                                  Expanded(
                                    // optional flex property if flex is 1 because the default flex is 1
                                    flex: 1,

                                    child: TextFormField(
                                      controller: address,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                          labelText: 'Enter home address',
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red, width: 1))),
                                    ),

                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  // optional flex property if flex is 1 because the default flex is 1
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () {

                                      _selectDate(context);
                                      date = true;
                                    },

                                    child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                                    style: ElevatedButton.styleFrom(primary: Color(0xff388E3C)),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Expanded(

                                  flex: 1,
                                  child: MaterialButton(
                                    color: isDisabled == true ? Colors.grey : Color(0xff388E3C),
                                    onPressed: () async{

                                      var connection = await Connectivity().checkConnectivity();
                                      if(connection == ConnectivityResult.none && isDisabled == true){
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
                                        time = true;
                                        getDay();
                                      }


                                    },
                                    child: Text(val ?? timename, style: TextStyle(color: Colors.white),),
                                    //     style: ElevatedButton.styleFrom(primary: Color(0xff388E3C)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  // optional flex property if flex is 1 because the default flex is 1
                                  flex: 1,
                                  child: MaterialButton(
                                    color: isDisabled == true ? Colors.grey : Color(0xff388E3C),
                                    onPressed: () async{
                                      var connection = await Connectivity().checkConnectivity();
                                      if(connection == ConnectivityResult.none && isDisabled == true){
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
                                        package = true;
                                        SelectDialog.showModal<PackageModel>(
                                          context,
                                          label: "Select Package",
                                          selectedValue: ex1,
                                          onFind: (String filter) => getPackageData(filter),
                                          onChange: (PackageModel selected) {
                                            setState(() {
                                              if (ex1?.pName == ex1?.pName) {
                                                setState((){
                                                  Visible = true;
                                                });
                                              } else {
                                                setState(() {
                                                  Visible = false;
                                                });
                                              }
                                              ex1 = selected;
                                            });
                                          },


                                        );
                                      }

                                    },
                                    child: Text(ex1?.pName?? packagename, style: TextStyle(color: Colors.white)),

                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Expanded(
                                  // optional flex property if flex is 1 because the default flex is 1
                                  flex: 1,
                                  child: MaterialButton(
                                    color: isDisabled == true ? Colors.grey : Color(0xff388E3C),
                                    onPressed: () async{
                                      var connection = await Connectivity().checkConnectivity();
                                      if(connection == ConnectivityResult.none && isDisabled == true){
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
                                        SelectDialog.showModal<VehicleModel>(
                                          context,
                                          label: "Select Vehicle",
                                          selectedValue: ex4,
                                          onFind: (String filter) => getData(filter),
                                          onChange: (VehicleModel selected) {
                                            setState(() {
                                              ex4 = selected;
                                              vehicle = true;
                                            });
                                          },
                                        );
                                      }

                                    },
                                    child: Text(ex4?.name ?? vehiclename,style:TextStyle(color: Colors.white)),

                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            // optional flex property if flex is 1 because the default flex is 1
                            child: MaterialButton(
                              color: isDisabled == true ? Colors.grey : Color(0xff388E3C),
                              onPressed: () async{
                                var connection = await Connectivity().checkConnectivity();
                                if(connection == ConnectivityResult.none && isDisabled == true){
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
                                  service = true;
                                  SelectDialog.showModal<ServiceModel>(
                                    context,
                                    label: "Select Service Center",
                                    selectedValue: ex2,
                                    onFind: (String filter) => getServiceData(filter),
                                    onChange: (ServiceModel selected) {
                                      setState(() {
                                        ex2 = selected;
                                      });
                                    },
                                  );
                                }
                              },
                              child: Text(ex2?.Branch_name ?? servicecenter, style: TextStyle(color: Colors.white),),

                            ),

                          ),
                          SizedBox(height: 10),
                          Visibility(
                            visible: Visible,
                            child: Container(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[

                                  SizedBox(height: 10.0),

                                  Expanded(
                                    // optional flex property if flex is 1 because the default flex is 1
                                    flex: 1,
                                    child:  Card(
                                        color: Colors.white,
                                        elevation: 4,
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
                                                Flexible(child: Text(ex1?.pName?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
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
                                                  SizedBox(
                                                    width: 10,
                                                  ),

                                                  Column(

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
                                                            Text(ex1?.Price.toString()??"",
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 14,
                                                                  color: Colors.red,
                                                                  decoration: TextDecoration.lineThrough
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
                                                            Text(ex1?.Discounted_Rate.toString()??"",
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
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,),

                                          ],
                                        )


                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                SizedBox(height: 10.0),

                                Expanded(
                                  // optional flex property if flex is 1 because the default flex is 1
                                  flex: 1,
                                  child: TextFormField(
                                    controller: vehicleno,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        labelText: 'Enter vehicle number',
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1))),
                                  ),

                                ),
                              ],
                            ),
                          ),
                          Container(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                SizedBox(height: 10.0),

                                Expanded(
                                  // optional flex property if flex is 1 because the default flex is 1
                                  flex: 1,

                                  child: TextFormField(
                                    controller: remarks,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        labelText: 'Remarks',
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1))),
                                  ),



                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                          Container(

                            child:Row(
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Expanded(
                                  // optional flex property if flex is 1 because the default flex is 1
                                  flex: 1,
                                  child: Text(
                                      "Please select the date, time slot, package, vehicle, location and hit the submit button to confirm your appointment."

                                  ),

                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            alignment: Alignment.centerRight,
                            // optional flex property if flex is 1 because the default flex is 1
                            child: ElevatedButton(onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AppointmentScreen(uid: uid,)));
                            },
                              child: Text("GO TO LIST"),
                              style: ElevatedButton.styleFrom(primary: Colors.amber),
                            ),

                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Swipe Down to Refresh",
                            style: TextStyle(fontSize: 15.0),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      ),

 floatingActionButton: FloatingActionButton.extended(
        onPressed: () {


           if(timename=="Time Slot" && val == null){
            final snackBar =
            SnackBar(content: Text('Please select time slot.'), backgroundColor: Colors.red);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
           else if(packagename=="Package" && ex1?.pName == null){
             final snackBar =
             SnackBar(content: Text('Please Select a Package.'), backgroundColor: Colors.red);
             ScaffoldMessenger.of(context).showSnackBar(snackBar);
           }
        else if(vehiclename=="Vehicle" && ex4?.name == null){
          final snackBar =
          SnackBar(content: Text('Please select a vehicle.'), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          else if(servicecenter=="Choose Service Center" && ex2?.Branch_name == null){
            final snackBar =
            SnackBar(content: Text('Please Choose Service Center'), backgroundColor: Colors.red);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          else if( _type=="Home" && address.text == ""){
             final snackBar =
             SnackBar(content: Text('Please Enter home address'), backgroundColor: Colors.red);
             ScaffoldMessenger.of(context).showSnackBar(snackBar);
           }

          else{
            setState(() {
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.loading,
                  text: "Booking Appointment",
                  barrierDismissible: false);
            });
            SendAppointment();
          }


        },
        label: const Text('Submit'),
        icon: const Icon(Icons.done_all),
        backgroundColor: Color(0xff388E3C),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }
  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    bool _decideWhichDayToEnable(DateTime day) {
      if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
          day.isBefore(DateTime.now().add(Duration(days: 6))))) {
        return true;
      }
      return false;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2021),
      lastDate: DateTime(2050),
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select booking date', // Can be used as title
      cancelText: 'Not now',
      confirmText: 'Book',
      fieldLabelText: 'Booking date',
      fieldHintText: 'Month/Date/Year',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      builder: (context, child) {
        return Theme(
          data: ThemeData(
              primarySwatch: Colors.green
          ), // This will change to light theme.
          child: Container(child: child),
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) async{
    bool _decideWhichDayTobeEnable(DateTime day) {
      if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
          day.isBefore(DateTime.now().add(Duration(days: 6))))) {
        return true;
      }
      return false;
    }


    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2021),
      lastDate: DateTime(2050),
      selectableDayPredicate: _decideWhichDayTobeEnable,
      helpText: 'Select booking date', // Can be used as title
      cancelText: 'Not now',
      confirmText: 'Book',
      fieldLabelText: 'Booking date',
      fieldHintText: 'Month/Date/Year',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      builder: (context, child) {
        return Theme(
          data: ThemeData(
              primarySwatch: Colors.green
          ), // This will change to light theme.
          child: Container(child: child),
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });

  }

  //////////////////////////////////////////////////////
/*  Vehicle Search*/
  Future<List<VehicleModel>> getData(String filter) async {
    var response = await Dio().get(
      "http://116.90.122.234:7777/api/Sale/VehicleList",
      queryParameters: {
        "Name": filter
      },
    );
    if(response.statusCode == 200){
      setState(() {
        isDisabled = false;
      });
    }
    else{
      print("good");
    }


    var models = VehicleModel.fromJsonList(response.data);
    return models;
  }

  /*  Package Search*/
  Future<List<PackageModel>> getPackageData(String filter) async {
    var response = await Dio().get(
      "http://116.90.122.234:7777/api/Sale/PackageList",
      queryParameters: {
        "PackageName": filter
      },
    );
    if(response.statusCode == 200){
      setState(() {
        isDisabled = false;
      });
    }
    else{
      print("good");
    }


    var models = PackageModel.fromJsonList(response.data);
    return models;
  }

  /*  Service Search*/
  Future<List<ServiceModel>> getServiceData(String filter) async {
    var response = await Dio().get("http://116.90.122.234:7777/api/Sale/GetBranchList", queryParameters: {"Branch_name": filter},);

   if(response.statusCode == 200){
     setState(() {
       isDisabled = false;
     });
   }
   else{
  print("good");
   }

      var models = ServiceModel.fromJsonList(response.data);
      return models;




  }


}
