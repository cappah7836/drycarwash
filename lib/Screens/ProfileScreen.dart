import 'package:avatar_glow/avatar_glow.dart';
import 'package:dio/dio.dart';
import 'package:drycarwash/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';


class ProfileScreen extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfileScreen>{
  int? uid;
  String uemail="";
  String? currpassword;
  String upassword="";
  String? cmpassword;
  String uname="";
  String uphone="";
  String? uno;
  bool isLoading = true;

  getUserData()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    uid = pref.getInt("userid")?? 0;
    uname = pref.getString("username")?? "";
    uphone = pref.getString("phone")?? "";
    uemail = pref.getString("email")?? "";
    upassword = pref.getString("password")?? "";
    print(uname);
    print(uphone);
    print(uemail);
    print(upassword);
    print(uid);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController currpass = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cfmpassword = TextEditingController();



  //////Update Name
  var response;

  UpdateName() async {
    var dioRequest = Dio();
    dioRequest.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "EMAIL":uemail,
      "CUSTOMER_ID":uid,
      "MOBILE_NO":uphone,
      "CUSTOMER_NAME":name.text,

    });


    response = await dioRequest.post("Sale/UpdateCustomer", data: formData);
    if (response.statusCode == 200) {
      print(response.data["obj"]);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        uname = response.data["obj"]["customeR_NAME"];
        sharedPreferences.setString("username", uname);
      });

      var message = response.data['message'];

      if (message == "Updated Successfully") {
        final snackBar =
        SnackBar(content: Text('Name updated successfully'), backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();


      }
      else if (message == "customer's record not exist!") {
        final snackBar =
        SnackBar(content: Text('Wrong Information'), backgroundColor: Colors.amber);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      else{
        final snackBar = SnackBar(
            content: Text('Server not responding!'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print("Error...");
    }
  }

  //////Update Phone
  var presponse;

  UpdatePhone() async {
    var dioRequest = Dio();
    dioRequest.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "EMAIL":uemail,
      "CUSTOMER_ID":uid,
      "MOBILE_NO":"92"+phone.text,
      "CUSTOMER_NAME":uname,

    });


    response = await dioRequest.post("Sale/UpdateCustomer", data: formData);
    if (response.statusCode == 200) {
      print(response.data["obj"]);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        uphone = response.data["obj"]["mobilE_NO"];
        sharedPreferences.setString("phone", uphone);
      });

      var message = response.data['message'];

      if (message == "Updated Successfully") {
        final snackBar =
        SnackBar(content: Text('Phone updated successfully'), backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();


      }
      else if (message == "customer's record not exist!") {
        final snackBar =
        SnackBar(content: Text('Wrong Information'), backgroundColor: Colors.amber);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      else{
        final snackBar = SnackBar(
            content: Text('Server not responding!'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print("Error...");
    }
  }

  /////Update Email
  var eresponse;

  UpdateEmail() async {
    var dioRequest = Dio();
    dioRequest.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "EMAIL":email.text,
      "CUSTOMER_ID":uid,
      "MOBILE_NO":uphone,
      "CUSTOMER_NAME":uname,

    });


    response = await dioRequest.post("Sale/UpdateCustomer", data: formData);
    if (response.statusCode == 200) {
      print(response.data["obj"]);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        uemail = response.data["obj"]["email"];
        sharedPreferences.setString("email", uemail);
      });

      var message = response.data['message'];

      if (message == "Updated Successfully") {
        final snackBar =
        SnackBar(content: Text('Email updated successfully'), backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();


      }
      else if (message == "customer's record not exist!") {
        final snackBar =
        SnackBar(content: Text('Wrong Information'), backgroundColor: Colors.amber);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      else{
        final snackBar = SnackBar(
            content: Text('Server not responding!'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print("Error...");
    }
  }

  /////Update Password
  var passresponse;

  UpdatePass() async {
    var dioRequest = Dio();
    dioRequest.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "id":uid,
      "password": password.text

    });


    response = await dioRequest.post("Sale/ResetForgetPassword", data: formData);
    if (response.statusCode == 200) {
      print(response.data["obj"]);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        upassword = response.data["obj"];
        sharedPreferences.setString("password", upassword);
      });

      var message = response.data['message'];

      if (message == "Updated Successfully") {
        final snackBar =
        SnackBar(content: Text('Password updated successfully'), backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();


      }
      else if (message == "customer's record not exist!") {
        final snackBar =
        SnackBar(content: Text('Wrong Information'), backgroundColor: Colors.amber);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      else{
        final snackBar = SnackBar(
            content: Text('Server not responding!'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print("Error...");
    }
  }


  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3= GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff388E3C),
          title: Text("Profile"),
          centerTitle: true,
          leading: IconButton(
            icon:Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      body: isLoading == true
          ? Center(
        child: CircularProgressIndicator(),
      )
          :SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 200,
              color: Color(0xff388E3C),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(
                top: 30,
                right: 20,
                left: 20,
              ),
              height: 200,
              width: double.infinity,


                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AvatarGlow(
                      startDelay: Duration(milliseconds: 1000),
                      glowColor: Color(0xff388E3C),
                      endRadius: 70.0,
                      duration: Duration(milliseconds: 2000),
                      repeat: true,
                      showTwoGlows: true,
                      repeatPauseDuration: Duration(milliseconds: 100),
                      child: Material(
                        elevation: 5.0,
                        shape: CircleBorder(),
                        color: Colors.transparent,
                        child:  CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[200],
                          child: Image.asset(
                            'assets/images/man.png',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      shape: BoxShape.circle,
                      animate: true,
                      curve: Curves.fastOutSlowIn,
                    ),

                    GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Update your name'),
                                content: Container(
                                  height: 150,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Flexible(
                                          child: Text("Your name makes our support team to confirm who they're sending promos"
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        TextFormField(
                                          controller: name,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter your name';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Enter your full name"),
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  new TextButton(
                                    child: new Text('Update'),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        UpdateName();
                                        name.text ="";
                                      }
                                    },
                                  ),
                                  new TextButton(
                                    child: new Text('Cancel', style: TextStyle(color: Colors.red),),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                      child: Text(
                        uname,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),

                  ],
                ),

            ),
            Container(
              margin: EdgeInsets.only(
                top: 240,
                right: 20,
                left: 20,
              ),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'USER INFO',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 300,
                right: 20,
                left: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile Settings',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.phone,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Update your mobile number'),
                                    content: Container(
                                      height: 150,
                                      child: Form(
                                        key: _formKey2,
                                        child: Column(
                                          children: [
                                            Flexible(
                                              child: Text("We will send you the updates and promos to your new number"
                                                ),
                                            ),
                                            SizedBox(height: 10,),
                                            TextFormField(
                                              inputFormatters: [
                                                new LengthLimitingTextInputFormatter(10), // for mobile
                                                new FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
                                                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                              ],
                                              keyboardType: TextInputType.number,
                                              onSaved: (input) => uno = input!.replaceFirst(new RegExp(r'^0+'), ''),
                                              controller: phone,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter a number';
                                                }
                                                else if(value.length < 10){
                                                  return "Please enter a valid number";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: "New mobile number",
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                                                  child: Text(
                                                    " (+92) ",
                                                    style: TextStyle(color: Colors.black, fontSize: 15),
                                                  ),
                                                ),),

                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      new TextButton(
                                        child: new Text('Update'),
                                        onPressed: () {
                                          if (_formKey2.currentState!.validate()) {
                                              UpdatePhone();
                                              phone.text = "";
                                          }
                                        },
                                      ),
                                      new TextButton(
                                        child: new Text('Cancel', style: TextStyle(color: Colors.red),),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            uphone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.mail),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Update your email'),
                                    content: Container(
                                      height: 150,
                                      child: Form(
                                        key: _formKey3,
                                        child: Column(
                                          children: [
                                            Flexible(
                                              child: Text("Recieve info about new updates and awesome promos in your inbox"
                                                ),
                                            ),
                                            SizedBox(height: 10,),
                                            TextFormField(
                                              controller: email,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter an email';
                                                }
                                                else if(!emailValidatorRegExp.hasMatch(value)){
                                                  return 'Please enter an valid email';
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: "New email address"),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      new TextButton(
                                        child: new Text('Update'),
                                        onPressed: () {
                                          if (_formKey3.currentState!.validate()) {
                                            UpdateEmail();
                                            email.text ="";
                                          }
                                        },
                                      ),
                                      new TextButton(
                                        child: new Text('Cancel', style: TextStyle(color: Colors.red),),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            uemail,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.lock,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Update your password'),
                                    content: Container(
                                        height: 300,
                                        child: Form(
                                          key: _formKey4,
                                          child: Column(
                                            children: [
                                              TextFormField
                                                (
                                                controller: currpass,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter an password';
                                                  }
                                                  else if(value.length < 6){
                                                    return 'Password is too short';
                                                  }
                                                  else if(value != upassword) {
                                                    return 'Password did not matched';
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: "Current password"),
                                              ),
                                              SizedBox(height: 10,),
                                              TextFormField(
                                                controller: password,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter a new password';
                                                  }
                                                  else if(value.length < 6){
                                                    return 'Password is too short';
                                                  }
                                                },
                                                //   controller: _textFieldController,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),

                                                    hintText: "New password"),
                                              ),
                                              SizedBox(height: 10,),
                                              TextFormField(
                                                controller: cfmpassword,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter confirm password';
                                                  }
                                                  else if(value.length < 6){
                                                    return 'Password is too short';
                                                  }
                                                  else if(value.isNotEmpty && password == cfmpassword){
                                                    return "Passwords don't match";
                                                  }
                                                },
                                                //   controller: _textFieldController,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: "Confirm password"),
                                              ),
                                              SizedBox(height: 10,),
                                              Flexible(
                                                child: Text("Use at least 6 characters to create a password. Try to make it litle difficult"
                                                    , style: TextStyle(backgroundColor: Colors.grey),),
                                              ),

                                            ],
                                          ),
                                        ),

                                    ),
                                    actions: <Widget>[
                                      new TextButton(
                                        child: new Text('Update'),
                                        onPressed: () {
                                          if (_formKey4.currentState!.validate()) {
                                                UpdatePass();
                                                currpass.text ="";
                                                password.text ="";
                                                cfmpassword.text ="";

                                          }
                                        },
                                      ),
                                      new TextButton(
                                        child: new Text('Cancel', style: TextStyle(color: Colors.red),),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            upassword,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}