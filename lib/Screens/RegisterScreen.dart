


import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:drycarwash/Screens//LoginScreen.dart';
import 'package:drycarwash/components/constants.dart';
import 'package:drycarwash/components/form_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  bool _isObscure = true;
  String? uemail;
  String? upassword;
  String? ucfmpassword;
  String? uphone;
  String? uname;


  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cnfmpassword = TextEditingController();


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

  CustomerRegistration() async {
    var dioRequest = Dio();
    dioRequest.options.baseUrl = "http://116.90.122.234:7777/api/";
    String editedPhone = phone.text.replaceFirst(RegExp(r'^0+'), "");
    var formData = FormData.fromMap({
      "EMAIL":email.text,
      "CUSTOMER_PASSWORD":password.text,
      "CUSTOMER_NAME":name.text,
      "MOBILE_NO":"92"+editedPhone,
      "RECEIVEABLE_ACCOUNT_ID": "1",


    });


    response = await dioRequest.post("Sale/AddCustomers", data: formData);
    if (response.statusCode == 200) {
       print(response.data["obj"]);



      var message = response.data['message'];


      if (message == "Customer added successfully") {
        setState(() {
          Navigator.pop(context);
        });
        final snackBar =
        SnackBar(content: Text('User created successfully.'), backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginScreen()));


      } else if(message == "Customer Exist with same ContactNO Or Email!") {
        setState(() {
          Navigator.pop(context);
        });
        final snackBar = SnackBar(content: Text('Customer Already Exists!'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      else if (message == "Please enter complete customer Info!") {
        setState(() {
          Navigator.pop(context);
        });
        final snackBar =
        SnackBar(content: Text('Please enter complete customer Info!'), backgroundColor: Colors.amber);
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff388E3C),
            title: Text("Registration", textAlign: TextAlign.center,
                style: GoogleFonts.alegreyaSc(
                   fontWeight: FontWeight.bold)),
            leading: IconButton(
            icon:Icon(
              Icons.cancel_outlined,
              color: Colors.white,
            ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
            ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/car_logo.png'),
                    fit: BoxFit.fitWidth,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  )
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 12
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/logocar.png', scale: 1.5, width: 200,height: 50),
                      SizedBox(height: 10),
                      buildName(),
                      SizedBox(height: 10),
                      buildEmail(),
                      SizedBox(height: 10),
                      buildMobileNo(),
                      SizedBox(height: 10),
                      buildPassword(),
                      SizedBox(height: 10),
                      buildConfirmPassword(),
                      SizedBox(height: 10),
                      FormError(errors: errors),
                      buildRegisterBtn(),
                      buildLoginBtn()
                    ],
                  ),
                ),
              ),
            ),

          ],
        )
    );
  }
  buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
            controller: name,
          onSaved: (newValue) => uname = newValue!,
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError(error: KNameNullError);
            }
            return null;
          },
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: KNameNullError);
              return "";
            }
            return null;
          },
            keyboardType: TextInputType.name,
            style: TextStyle(
                color: Colors.black87
            ),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                    Icons.account_box_outlined,
                    color: Color(0xff5D5D59)
                ),
                hintText: 'Enter your name',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                )
            ),
          ),

      ],
    );
  }
  buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       TextFormField(
         controller: email,
         onSaved: (newValue) => uemail = newValue!,
         onChanged: (value) {
           if (value.isNotEmpty) {
             removeError(error: kEmailNullError);
           } else if (emailValidatorRegExp.hasMatch(value)) {
             removeError(error: kInvalidEmailError);
           }
           return null;
         },
         validator: (value) {
           if (value!.isEmpty) {
             addError(error: kEmailNullError);
             return "";
           } else if (!emailValidatorRegExp.hasMatch(value)) {
             addError(error: kInvalidEmailError);
             return "";
           }
           return null;
         },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.black87
            ),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xff5D5D59)
                ),
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                )
            ),
          ),

      ],
    );
  }
  buildMobileNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

       TextFormField(
         controller: phone,
         onSaved: (input) => uphone = input!.replaceFirst(new RegExp(r'^0+'), ''),
         inputFormatters: [
           new LengthLimitingTextInputFormatter(11), // for mobile
           /*  new BlacklistingTextInputFormatter(new RegExp('0')),*/
           FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
         ],
         onChanged: (value) {
           if (value.isNotEmpty) {
             removeError(error: KMobileNullError);
           }
           else if (value.length == 11) {
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
           }
           else if (value.length < 11) {
             addError(error: kInvalidNoError);
             return "";
           }
           else if (!novalidatorRegExp.hasMatch(value)) {
             addError(error: kInvalidNoError);
             return "";
           }
           return null;
         },
            keyboardType: TextInputType.phone,
            style: TextStyle(
                color: Colors.black87
            ),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                    Icons.phone,
                    color: Color(0xff5D5D59)
                ),
                hintText: 'Enter your mobile no',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                )
            ),
          ),

      ],
    );
  }
  buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        TextFormField(
          controller: password,
            obscureText: _isObscure,
          onSaved: (newValue) => upassword = newValue,
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError(error: kPassNullError);
            } else if (value.length < 6) {
              removeError(error: kShortPassError);
            }
            upassword = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: kPassNullError);
              return "";
            } else if (value.length < 6) {
              addError(error: kShortPassError);
              return "";
            }
            return null;
          },

          style: TextStyle(
                color: Colors.black87
            ),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xff5D5D59)
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                )
            ),
          ),

      ],
    );
  }
  buildConfirmPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
            obscureText: _isObscure,
          onSaved: (newValue) => ucfmpassword = newValue,
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError(error: kPassNullError);
            } else if (value.isNotEmpty && upassword == ucfmpassword) {
              removeError(error: kMatchPassError);
            }
            ucfmpassword = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: kPassNullError);
              return "";
            } else if ((upassword != value)) {
              addError(error: kMatchPassError);
              return "";
            }
            return null;
          },

          style: TextStyle(
                color: Colors.black87
            ),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                    Icons.check_circle_outline,
                    color: Color(0xff5D5D59)
                ),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                )
            ),
          ),

      ],
    );
  }


  buildRegisterBtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: 120,
      child: ElevatedButton(
        onPressed: (){
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            setState(() {
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.loading,
                  text: "Registering User",
                  barrierDismissible: false);
            });
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            CustomerRegistration();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'REGISTER',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )
          ],
        ),

      ),
    );
  }

  buildLoginBtn() {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      },
      child: RichText(

          text: TextSpan(
              children:[
                TextSpan(
                    text: 'Already Have An Account? ',
                    style: GoogleFonts.encodeSans(
                        color: Color(0xff5D5D59),
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    )
                ),
                TextSpan(
                    text: 'Login',
                    style: GoogleFonts.encodeSans(
                        color: Color(0xff388E3C),
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    )
                )
              ]
          )
      ),
    );
  }


}