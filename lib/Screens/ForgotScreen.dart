import 'package:dio/dio.dart';
import 'package:drycarwash/components/constants.dart';
import 'package:drycarwash/components/form_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LoginScreen.dart';

class ForgotScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForgotScreenState();
  }

}

class ForgotScreenState extends State<ForgotScreen>{
  String? uno;
  final TextEditingController number = TextEditingController();

  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  var response;

  ResetPassMessage() async {
    var dioRequest = Dio();
    dioRequest.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "mobileNo":"92"+number.text,

    });
    response = await dioRequest.post("Sale/ForgotMessage", data: formData);
    if (response.statusCode == 200) {
        print(response.data);
      var message = response.data['message'];

      if (message == "SMS sent successfully please check your Inbox!") {
        final snackBar =
        SnackBar(content: Text('SMS sent successfully please check your messages'), backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginScreen()));

      } else if(message == "Record not found against this Mobile No!") {
        final snackBar = SnackBar(content: Text('Record not found against this mobile no'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      else if (message == "Mobile No is not in Proper Format!") {
        final snackBar =
        SnackBar(content: Text('Mobile No is not in Proper Format!'), backgroundColor: Colors.amber);
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
               color: Colors.white,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 50,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/car_logo.png', scale: 1, width: 100,height: 100),
                        Image.asset('assets/images/drycarwashlogo.jpg', scale: 1, width: 300,height: 120),
                        buildText(),
                        SizedBox(height: 10),
                        FormError(errors: errors),
                        buildMobile(),
                        buildResetBtn(),

                      ],

                    ),
                  ),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 10),
        TextFormField(
          controller: number,
          autofocus: true,
          inputFormatters: [
            new LengthLimitingTextInputFormatter(10), // for mobile
            new FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
            keyboardType: TextInputType.number,
           onSaved: (input) => uno = input!.replaceFirst(new RegExp(r'^0+'), ''),
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError(error: KMobileNullError);
            } else if (value.length == 10) {
              removeError(error: kInvalidNoError);
            }
            else if (novalidatorRegExp.hasMatch(value)) {
              removeError(error: kInvalidNoError);
            }
            return null;
          },
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: KMobileNullError);
              return "";
            } else if (value.length < 10) {
              addError(error: kInvalidNoError);
              return "";
            }
            else if (!novalidatorRegExp.hasMatch(value)) {
              addError(error: kInvalidNoError);
              return "";
            }
            return null;
          },
            style: TextStyle(
                color: Colors.black87
            ),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(top: 14),
               prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                 child: Text(
                   " (+92) ",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                     ),
                   ),
                hintText: 'Enter your Mobile No',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                )
            ),
          ),

      ],
    );
  }

  buildResetBtn() {
    return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: new ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    elevation: 5,
                    child: Text(
                      'Submit',
                      style: GoogleFonts.encodeSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    color: Color(0xff388E3C),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ResetPassMessage();
                      }
                    },
                  ),
                  FlatButton(
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.encodeSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                      color: Color(0xff5D5D59),
                    onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));},
                  ),
            ],
              ),
            ),
          ],
        )
    );
  }


  buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Get Your Password',
          style: GoogleFonts.encodeSans(
              color: Colors.black,
              fontSize: 16,
              fontWeight:  FontWeight.bold
          ),
        ),
        SizedBox(height: 5),
        Container(
          alignment: Alignment.centerLeft,
         height: 50,
          child: Text(
            'Enter your mobile number and Submit the form',
            style: GoogleFonts.encodeSans(
              color: Colors.black,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 50,
          child: Text(
            'Number format should start from 323*******, Otherwise u will not receive a reset pass message.',
            style: GoogleFonts.encodeSans(
              color: Colors.black,
            ),
          ),
        )

      ],
    );
  }
}